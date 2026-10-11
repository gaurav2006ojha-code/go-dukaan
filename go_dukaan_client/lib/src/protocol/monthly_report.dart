/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class MonthlyReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MonthlyReport._({
    required this.monthStart,
    required this.totalSales,
    required this.totalReceived,
    required this.totalSalesDue,
    required this.totalDiscount,
    required this.totalTax,
    required this.totalPurchases,
    required this.totalPurchasePaid,
    required this.totalPurchaseDue,
    required this.grossProfit,
    required this.billCount,
    required this.purchaseCount,
  });

  factory MonthlyReport({
    required DateTime monthStart,
    required double totalSales,
    required double totalReceived,
    required double totalSalesDue,
    required double totalDiscount,
    required double totalTax,
    required double totalPurchases,
    required double totalPurchasePaid,
    required double totalPurchaseDue,
    required double grossProfit,
    required int billCount,
    required int purchaseCount,
  }) = _MonthlyReportImpl;

  factory MonthlyReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return MonthlyReport(
      monthStart: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['monthStart'],
      ),
      totalSales: (jsonSerialization['totalSales'] as num).toDouble(),
      totalReceived: (jsonSerialization['totalReceived'] as num).toDouble(),
      totalSalesDue: (jsonSerialization['totalSalesDue'] as num).toDouble(),
      totalDiscount: (jsonSerialization['totalDiscount'] as num).toDouble(),
      totalTax: (jsonSerialization['totalTax'] as num).toDouble(),
      totalPurchases: (jsonSerialization['totalPurchases'] as num).toDouble(),
      totalPurchasePaid: (jsonSerialization['totalPurchasePaid'] as num)
          .toDouble(),
      totalPurchaseDue: (jsonSerialization['totalPurchaseDue'] as num)
          .toDouble(),
      grossProfit: (jsonSerialization['grossProfit'] as num).toDouble(),
      billCount: jsonSerialization['billCount'] as int,
      purchaseCount: jsonSerialization['purchaseCount'] as int,
    );
  }

  DateTime monthStart;

  double totalSales;

  double totalReceived;

  double totalSalesDue;

  double totalDiscount;

  double totalTax;

  double totalPurchases;

  double totalPurchasePaid;

  double totalPurchaseDue;

  double grossProfit;

  int billCount;

  int purchaseCount;

  /// Returns a shallow copy of this [MonthlyReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MonthlyReport copyWith({
    DateTime? monthStart,
    double? totalSales,
    double? totalReceived,
    double? totalSalesDue,
    double? totalDiscount,
    double? totalTax,
    double? totalPurchases,
    double? totalPurchasePaid,
    double? totalPurchaseDue,
    double? grossProfit,
    int? billCount,
    int? purchaseCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MonthlyReport',
      'monthStart': monthStart.toJson(),
      'totalSales': totalSales,
      'totalReceived': totalReceived,
      'totalSalesDue': totalSalesDue,
      'totalDiscount': totalDiscount,
      'totalTax': totalTax,
      'totalPurchases': totalPurchases,
      'totalPurchasePaid': totalPurchasePaid,
      'totalPurchaseDue': totalPurchaseDue,
      'grossProfit': grossProfit,
      'billCount': billCount,
      'purchaseCount': purchaseCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MonthlyReport',
      'monthStart': monthStart.toJson(),
      'totalSales': totalSales,
      'totalReceived': totalReceived,
      'totalSalesDue': totalSalesDue,
      'totalDiscount': totalDiscount,
      'totalTax': totalTax,
      'totalPurchases': totalPurchases,
      'totalPurchasePaid': totalPurchasePaid,
      'totalPurchaseDue': totalPurchaseDue,
      'grossProfit': grossProfit,
      'billCount': billCount,
      'purchaseCount': purchaseCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MonthlyReportImpl extends MonthlyReport {
  _MonthlyReportImpl({
    required DateTime monthStart,
    required double totalSales,
    required double totalReceived,
    required double totalSalesDue,
    required double totalDiscount,
    required double totalTax,
    required double totalPurchases,
    required double totalPurchasePaid,
    required double totalPurchaseDue,
    required double grossProfit,
    required int billCount,
    required int purchaseCount,
  }) : super._(
         monthStart: monthStart,
         totalSales: totalSales,
         totalReceived: totalReceived,
         totalSalesDue: totalSalesDue,
         totalDiscount: totalDiscount,
         totalTax: totalTax,
         totalPurchases: totalPurchases,
         totalPurchasePaid: totalPurchasePaid,
         totalPurchaseDue: totalPurchaseDue,
         grossProfit: grossProfit,
         billCount: billCount,
         purchaseCount: purchaseCount,
       );

  /// Returns a shallow copy of this [MonthlyReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MonthlyReport copyWith({
    DateTime? monthStart,
    double? totalSales,
    double? totalReceived,
    double? totalSalesDue,
    double? totalDiscount,
    double? totalTax,
    double? totalPurchases,
    double? totalPurchasePaid,
    double? totalPurchaseDue,
    double? grossProfit,
    int? billCount,
    int? purchaseCount,
  }) {
    return MonthlyReport(
      monthStart: monthStart ?? this.monthStart,
      totalSales: totalSales ?? this.totalSales,
      totalReceived: totalReceived ?? this.totalReceived,
      totalSalesDue: totalSalesDue ?? this.totalSalesDue,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      totalTax: totalTax ?? this.totalTax,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      totalPurchasePaid: totalPurchasePaid ?? this.totalPurchasePaid,
      totalPurchaseDue: totalPurchaseDue ?? this.totalPurchaseDue,
      grossProfit: grossProfit ?? this.grossProfit,
      billCount: billCount ?? this.billCount,
      purchaseCount: purchaseCount ?? this.purchaseCount,
    );
  }
}
