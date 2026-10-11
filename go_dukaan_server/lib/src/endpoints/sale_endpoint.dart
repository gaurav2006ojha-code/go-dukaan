
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class SaleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Shop> _getMyShop(Session session) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('User is not authenticated.');
    }

    final shop = await Shop.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (shop == null || shop.id == null) {
      throw Exception('Shop not found.');
    }

    return shop;
  }

  Future<List<Sale>> getSales(Session session) async {
    final shop = await _getMyShop(session);

    return Sale.db.find(
      session,
      where: (t) => t.shopId.equals(shop.id!),
      orderBy: (t) => t.createdAt,
      limit: 100,
    );
  }

  Future<Sale?> getSale(
    Session session,
    int saleId,
  ) async {
    final shop = await _getMyShop(session);

    return Sale.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(saleId) &
          t.shopId.equals(shop.id!),
    );
  }

  Future<List<SaleItem>> getSaleItems(
    Session session,
    int saleId,
  ) async {
    final shop = await _getMyShop(session);

    final sale = await Sale.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(saleId) &
          t.shopId.equals(shop.id!),
    );

    if (sale == null) {
      throw Exception('Sale not found.');
    }

    return SaleItem.db.find(
      session,
      where: (t) => t.saleId.equals(saleId),
      orderBy: (t) => t.id,
    );
  }

  Future<Sale> createSale(
    Session session, {
    int? customerId,
    required List<int> productIds,
    required List<int> quantities,
    double discountAmount = 0,
    double taxPercent = 0,
    required String paymentMethod,
    required double paidAmount,
    String? notes,
  }) async {
    final shop = await _getMyShop(session);
    final shopId = shop.id!;

    if (productIds.isEmpty ||
        productIds.length != quantities.length) {
      throw Exception('Invalid sale items.');
    }

    if (productIds.toSet().length != productIds.length) {
      throw Exception(
        'Duplicate products are not allowed. Combine their quantities.',
      );
    }

    if (quantities.any((quantity) => quantity <= 0)) {
      throw Exception('Quantity must be greater than zero.');
    }

    if (!discountAmount.isFinite ||
        !taxPercent.isFinite ||
        !paidAmount.isFinite ||
        discountAmount < 0 ||
        taxPercent < 0 ||
        taxPercent > 100 ||
        paidAmount < 0) {
      throw Exception('Invalid discount, tax or payment amount.');
    }

    const allowedMethods = {
      'Cash',
      'UPI',
      'Card',
      'Credit',
      'Partial',
    };

    if (!allowedMethods.contains(paymentMethod)) {
      throw Exception('Unsupported payment method.');
    }

    if (customerId != null) {
      final customer = await Customer.db.findById(
        session,
        customerId,
      );

      if (customer == null || customer.shopId != shopId) {
        throw Exception('Customer not found in this shop.');
      }
    }

    return await session.db.transaction((transaction) async {
      final now = DateTime.now();
      final invoiceNumber =
          'GD-$shopId-${now.microsecondsSinceEpoch}';

      final List<Product> products = [];
      final List<double> lineTotals = [];
      final List<double> itemDiscounts = [];

      double subtotal = 0;

      for (var i = 0; i < productIds.length; i++) {
        final product = await Product.db.findById(
          session,
          productIds[i],
          transaction: transaction,
        );

        if (product == null ||
            product.shopId != shopId ||
            !product.isActive) {
          throw Exception(
            'A selected product is unavailable.',
          );
        }

        final quantity = quantities[i];

        if (product.stockQuantity < quantity) {
          throw Exception(
            'Insufficient stock for ${product.name}. '
            'Available: ${product.stockQuantity}.',
          );
        }

        if (!product.sellingPrice.isFinite ||
            !product.purchasePrice.isFinite ||
            product.sellingPrice < 0 ||
            product.purchasePrice < 0) {
          throw Exception(
            'Invalid price for ${product.name}.',
          );
        }

        final lineTotal = product.sellingPrice * quantity;

        products.add(product);
        lineTotals.add(lineTotal);
        itemDiscounts.add(0);
        subtotal += lineTotal;
      }

      if (discountAmount > subtotal) {
        throw Exception(
          'Discount cannot exceed the subtotal.',
        );
      }

      final taxableAmount = subtotal - discountAmount;
      final taxAmount = taxableAmount * taxPercent / 100;
      final totalAmount = taxableAmount + taxAmount;

      if (paidAmount > totalAmount + 0.000001) {
        throw Exception(
          'Paid amount cannot exceed the bill total.',
        );
      }

      final dueAmount =
          (totalAmount - paidAmount).clamp(0.0, double.infinity);

      if (paymentMethod == 'Credit' && paidAmount != 0) {
        throw Exception(
          'For Credit payment, paid amount must be zero.',
        );
      }

      if (paymentMethod == 'Cash' ||
          paymentMethod == 'UPI' ||
          paymentMethod == 'Card') {
        if ((paidAmount - totalAmount).abs() > 0.000001) {
          throw Exception(
            'Use Partial payment for an incomplete payment.',
          );
        }
      }

      final sale = Sale(
        shopId: shopId,
        customerId: customerId,
        invoiceNumber: invoiceNumber,
        subtotal: subtotal,
        discountAmount: discountAmount,
        taxAmount: taxAmount,
        totalAmount: totalAmount,
        paidAmount: paidAmount,
        dueAmount: dueAmount,
        paymentMethod: paymentMethod,
        status: dueAmount > 0 ? 'Pending' : 'Paid',
        notes: notes,
        createdAt: now,
        updatedAt: now,
      );

      final savedSale = await Sale.db.insertRow(
        session,
        sale,
        transaction: transaction,
      );

      for (var i = 0; i < products.length; i++) {
        final product = products[i];
        final quantity = quantities[i];

        final item = SaleItem(
          saleId: savedSale.id!,
          productId: product.id!,
          productName: product.name,
          quantity: quantity,
          unitPrice: product.sellingPrice,
          purchasePrice: product.purchasePrice,
          discountAmount: itemDiscounts[i],
          lineTotal: lineTotals[i],
          createdAt: now,
        );

        await SaleItem.db.insertRow(
          session,
          item,
          transaction: transaction,
        );

        final updatedProduct = product.copyWith(
          stockQuantity: product.stockQuantity - quantity,
          updatedAt: now,
        );

        await Product.db.updateRow(
          session,
          updatedProduct,
          transaction: transaction,
        );
      }

      if (customerId != null) {
        final customer = await Customer.db.findById(
          session,
          customerId,
          transaction: transaction,
        );

        if (customer == null || customer.shopId != shopId) {
          throw Exception('Customer no longer exists.');
        }

        final updatedCustomer = customer.copyWith(
          totalDue: customer.totalDue + dueAmount,
          totalPaid: customer.totalPaid + paidAmount,
          updatedAt: now,
        );

        await Customer.db.updateRow(
          session,
          updatedCustomer,
          transaction: transaction,
        );
      }

      return savedSale;
    });
  }
}
