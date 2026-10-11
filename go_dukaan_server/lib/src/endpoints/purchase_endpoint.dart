
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class PurchaseEndpoint extends Endpoint {
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

  Future<int> createPurchase(
    Session session, {
    required String supplierName,
    String? supplierPhone,
    required String invoiceNumber,
    required double paidAmount,
    String? notes,
    required DateTime purchasedAt,
    required List<Map<String, dynamic>> items,
  }) async {
    final shop = await _getMyShop(session);

    if (supplierName.trim().isEmpty) {
      throw Exception('Supplier name is required.');
    }

    if (invoiceNumber.trim().isEmpty) {
      throw Exception('Invoice number is required.');
    }

    if (!paidAmount.isFinite || paidAmount < 0) {
      throw Exception('Invalid paid amount.');
    }

    if (items.isEmpty) {
      throw Exception('Add at least one product.');
    }

    final parsedItems = <PurchaseItem>[];
    double totalAmount = 0;
    final productIds = <int>{};

    for (final item in items) {
      final productId = item['productId'];
      final quantity = item['quantity'];
      final rawPrice = item['unitPurchasePrice'];

      if (productId is! int ||
          quantity is! int ||
          rawPrice is! num) {
        throw Exception('Invalid purchase item data.');
      }

      final unitPrice = rawPrice.toDouble();

      if (productId <= 0 ||
          quantity <= 0 ||
          !unitPrice.isFinite ||
          unitPrice < 0) {
        throw Exception('Invalid product, quantity, or price.');
      }

      if (!productIds.add(productId)) {
        throw Exception(
          'Duplicate products are not allowed. Combine quantities.',
        );
      }

      final product = await Product.db.findById(
        session,
        productId,
      );

      if (product == null || product.shopId != shop.id) {
        throw Exception('Product not found in your shop: $productId');
      }

      final lineTotal = quantity * unitPrice;
      totalAmount += lineTotal;

      parsedItems.add(
        PurchaseItem(
          purchaseId: 0,
          productId: productId,
          productName: product.name,
          quantity: quantity,
          unitPurchasePrice: unitPrice,
          lineTotal: lineTotal,
        ),
      );
    }

    if (!totalAmount.isFinite || paidAmount > totalAmount) {
      throw Exception('Paid amount cannot exceed total amount.');
    }

    return await session.db.transaction((transaction) async {
      final purchase = await Purchase.db.insertRow(
        session,
        Purchase(
          shopId: shop.id!,
          supplierName: supplierName.trim(),
          supplierPhone: supplierPhone,
          invoiceNumber: invoiceNumber.trim(),
          totalAmount: totalAmount,
          paidAmount: paidAmount,
          dueAmount: totalAmount - paidAmount,
          notes: notes,
          purchasedAt: purchasedAt,
          createdAt: DateTime.now(),
        ),
        transaction: transaction,
      );

      for (final item in parsedItems) {
        await PurchaseItem.db.insertRow(
          session,
          item.copyWith(purchaseId: purchase.id!),
          transaction: transaction,
        );

        final product = await Product.db.findById(
          session,
          item.productId,
          transaction: transaction,
        );

        if (product == null || product.shopId != shop.id) {
          throw Exception('Product not found during stock update.');
        }

        await Product.db.updateRow(
          session,
          product.copyWith(
            stockQuantity: product.stockQuantity + item.quantity,
            purchasePrice: item.unitPurchasePrice,
            updatedAt: DateTime.now(),
          ),
          transaction: transaction,
        );
      }

      return purchase.id!;
    });
  }

  Future<List<Purchase>> getPurchases(Session session) async {
    final shop = await _getMyShop(session);

    final purchases = await Purchase.db.find(
      session,
      where: (t) => t.shopId.equals(shop.id!),
      orderBy: (t) => t.purchasedAt,
      limit: 100,
    );

    purchases.sort(
      (a, b) => b.purchasedAt.compareTo(a.purchasedAt),
    );

    return purchases;
  }

  Future<List<PurchaseItem>> getPurchaseItems(
    Session session,
    int purchaseId,
  ) async {
    final shop = await _getMyShop(session);

    final purchase = await Purchase.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(purchaseId) &
          t.shopId.equals(shop.id!),
    );

    if (purchase == null) {
      throw Exception('Purchase not found.');
    }

    return await PurchaseItem.db.find(
      session,
      where: (t) => t.purchaseId.equals(purchaseId),
      orderBy: (t) => t.id,
    );
  }
}
