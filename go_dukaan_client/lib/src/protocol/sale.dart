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

abstract class Sale
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Sale._({
    this.id,
    required this.shopId,
    this.customerId,
    required this.invoiceNumber,
    required this.subtotal,
    required this.discountAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentMethod,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sale({
    int? id,
    required int shopId,
    int? customerId,
    required String invoiceNumber,
    required double subtotal,
    required double discountAmount,
    required double taxAmount,
    required double totalAmount,
    required double paidAmount,
    required double dueAmount,
    required String paymentMethod,
    required String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SaleImpl;

  factory Sale.fromJson(Map<String, dynamic> jsonSerialization) {
    return Sale(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      customerId: jsonSerialization['customerId'] as int?,
      invoiceNumber: jsonSerialization['invoiceNumber'] as String,
      subtotal: (jsonSerialization['subtotal'] as num).toDouble(),
      discountAmount: (jsonSerialization['discountAmount'] as num).toDouble(),
      taxAmount: (jsonSerialization['taxAmount'] as num).toDouble(),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      paidAmount: (jsonSerialization['paidAmount'] as num).toDouble(),
      dueAmount: (jsonSerialization['dueAmount'] as num).toDouble(),
      paymentMethod: jsonSerialization['paymentMethod'] as String,
      status: jsonSerialization['status'] as String,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int shopId;

  int? customerId;

  String invoiceNumber;

  double subtotal;

  double discountAmount;

  double taxAmount;

  double totalAmount;

  double paidAmount;

  double dueAmount;

  String paymentMethod;

  String status;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Sale]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Sale copyWith({
    int? id,
    int? shopId,
    int? customerId,
    String? invoiceNumber,
    double? subtotal,
    double? discountAmount,
    double? taxAmount,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,
    String? paymentMethod,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Sale',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (customerId != null) 'customerId': customerId,
      'invoiceNumber': invoiceNumber,
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentMethod': paymentMethod,
      'status': status,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Sale',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (customerId != null) 'customerId': customerId,
      'invoiceNumber': invoiceNumber,
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentMethod': paymentMethod,
      'status': status,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SaleImpl extends Sale {
  _SaleImpl({
    int? id,
    required int shopId,
    int? customerId,
    required String invoiceNumber,
    required double subtotal,
    required double discountAmount,
    required double taxAmount,
    required double totalAmount,
    required double paidAmount,
    required double dueAmount,
    required String paymentMethod,
    required String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
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
         status: status,
         notes: notes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Sale]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Sale copyWith({
    Object? id = _Undefined,
    int? shopId,
    Object? customerId = _Undefined,
    String? invoiceNumber,
    double? subtotal,
    double? discountAmount,
    double? taxAmount,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,
    String? paymentMethod,
    String? status,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Sale(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      customerId: customerId is int? ? customerId : this.customerId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      subtotal: subtotal ?? this.subtotal,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
