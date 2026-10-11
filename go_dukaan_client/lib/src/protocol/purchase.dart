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

abstract class Purchase
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Purchase._({
    this.id,
    required this.shopId,
    required this.supplierName,
    this.supplierPhone,
    required this.invoiceNumber,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    this.notes,
    required this.purchasedAt,
    required this.createdAt,
  });

  factory Purchase({
    int? id,
    required int shopId,
    required String supplierName,
    String? supplierPhone,
    required String invoiceNumber,
    required double totalAmount,
    required double paidAmount,
    required double dueAmount,
    String? notes,
    required DateTime purchasedAt,
    required DateTime createdAt,
  }) = _PurchaseImpl;

  factory Purchase.fromJson(Map<String, dynamic> jsonSerialization) {
    return Purchase(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      supplierName: jsonSerialization['supplierName'] as String,
      supplierPhone: jsonSerialization['supplierPhone'] as String?,
      invoiceNumber: jsonSerialization['invoiceNumber'] as String,
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      paidAmount: (jsonSerialization['paidAmount'] as num).toDouble(),
      dueAmount: (jsonSerialization['dueAmount'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String?,
      purchasedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['purchasedAt'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int shopId;

  String supplierName;

  String? supplierPhone;

  String invoiceNumber;

  double totalAmount;

  double paidAmount;

  double dueAmount;

  String? notes;

  DateTime purchasedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Purchase copyWith({
    int? id,
    int? shopId,
    String? supplierName,
    String? supplierPhone,
    String? invoiceNumber,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,
    String? notes,
    DateTime? purchasedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Purchase',
      if (id != null) 'id': id,
      'shopId': shopId,
      'supplierName': supplierName,
      if (supplierPhone != null) 'supplierPhone': supplierPhone,
      'invoiceNumber': invoiceNumber,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      if (notes != null) 'notes': notes,
      'purchasedAt': purchasedAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Purchase',
      if (id != null) 'id': id,
      'shopId': shopId,
      'supplierName': supplierName,
      if (supplierPhone != null) 'supplierPhone': supplierPhone,
      'invoiceNumber': invoiceNumber,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      if (notes != null) 'notes': notes,
      'purchasedAt': purchasedAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PurchaseImpl extends Purchase {
  _PurchaseImpl({
    int? id,
    required int shopId,
    required String supplierName,
    String? supplierPhone,
    required String invoiceNumber,
    required double totalAmount,
    required double paidAmount,
    required double dueAmount,
    String? notes,
    required DateTime purchasedAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         shopId: shopId,
         supplierName: supplierName,
         supplierPhone: supplierPhone,
         invoiceNumber: invoiceNumber,
         totalAmount: totalAmount,
         paidAmount: paidAmount,
         dueAmount: dueAmount,
         notes: notes,
         purchasedAt: purchasedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Purchase copyWith({
    Object? id = _Undefined,
    int? shopId,
    String? supplierName,
    Object? supplierPhone = _Undefined,
    String? invoiceNumber,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,
    Object? notes = _Undefined,
    DateTime? purchasedAt,
    DateTime? createdAt,
  }) {
    return Purchase(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      supplierName: supplierName ?? this.supplierName,
      supplierPhone: supplierPhone is String?
          ? supplierPhone
          : this.supplierPhone,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      notes: notes is String? ? notes : this.notes,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
