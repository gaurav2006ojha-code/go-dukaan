import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class ReportEndpoint extends Endpoint {
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

  Future<MonthlyReport> getMonthlyReport(
    Session session,
    DateTime month,
  ) async {
    final shop = await _getMyShop(session);
    final shopId = shop.id!;

    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month + 1);

    final sales = await Sale.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shopId) &
          (t.createdAt >= start) &
          (t.createdAt < end),
    );

    final purchases = await Purchase.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shopId) &
          (t.purchasedAt >= start) &
          (t.purchasedAt < end),
    );

    double totalSales = 0;
    double totalReceived = 0;
    double totalSalesDue = 0;
    double totalDiscount = 0;
    double totalTax = 0;
    double totalCost = 0;

    for (final sale in sales) {
      totalSales += sale.totalAmount;
      totalReceived += sale.paidAmount;
      totalSalesDue += sale.dueAmount;
      totalDiscount += sale.discountAmount;
      totalTax += sale.taxAmount;

      final items = await SaleItem.db.find(
        session,
        where: (t) => t.saleId.equals(sale.id!),
      );

      for (final item in items) {
        totalCost += item.purchasePrice * item.quantity;
      }
    }

    double totalPurchases = 0;
    double totalPurchasePaid = 0;
    double totalPurchaseDue = 0;

    for (final purchase in purchases) {
      totalPurchases += purchase.totalAmount;
      totalPurchasePaid += purchase.paidAmount;
      totalPurchaseDue += purchase.dueAmount;
    }

    // Gross profit uses pre-tax sales after bill discount, minus item cost.
    // This avoids treating collected tax as business revenue.
    final grossProfit =
        totalSales - totalTax - totalCost;

    return MonthlyReport(
      monthStart: start,
      totalSales: totalSales,
      totalReceived: totalReceived,
      totalSalesDue: totalSalesDue,
      totalDiscount: totalDiscount,
      totalTax: totalTax,
      totalPurchases: totalPurchases,
      totalPurchasePaid: totalPurchasePaid,
      totalPurchaseDue: totalPurchaseDue,
      grossProfit: grossProfit,
      billCount: sales.length,
      purchaseCount: purchases.length,
    );
  }
}