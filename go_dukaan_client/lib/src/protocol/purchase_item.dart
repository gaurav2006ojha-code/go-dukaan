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

abstract class PurchaseItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PurchaseItem._({
    this.id,
    required this.purchaseId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPurchasePrice,
    required this.lineTotal,
  });

  factory PurchaseItem({
    int? id,
    required int purchaseId,
    required int productId,
    required String productName,
    required int quantity,
    required double unitPurchasePrice,
    required double lineTotal,
  }) = _PurchaseItemImpl;

  factory PurchaseItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return PurchaseItem(
      id: jsonSerialization['id'] as int?,
      purchaseId: jsonSerialization['purchaseId'] as int,
      productId: jsonSerialization['productId'] as int,
      productName: jsonSerialization['productName'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPurchasePrice: (jsonSerialization['unitPurchasePrice'] as num)
          .toDouble(),
      lineTotal: (jsonSerialization['lineTotal'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int purchaseId;

  int productId;

  String productName;

  int quantity;

  double unitPurchasePrice;

  double lineTotal;

  /// Returns a shallow copy of this [PurchaseItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PurchaseItem copyWith({
    int? id,
    int? purchaseId,
    int? productId,
    String? productName,
    int? quantity,
    double? unitPurchasePrice,
    double? lineTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PurchaseItem',
      if (id != null) 'id': id,
      'purchaseId': purchaseId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPurchasePrice': unitPurchasePrice,
      'lineTotal': lineTotal,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PurchaseItem',
      if (id != null) 'id': id,
      'purchaseId': purchaseId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPurchasePrice': unitPurchasePrice,
      'lineTotal': lineTotal,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PurchaseItemImpl extends PurchaseItem {
  _PurchaseItemImpl({
    int? id,
    required int purchaseId,
    required int productId,
    required String productName,
    required int quantity,
    required double unitPurchasePrice,
    required double lineTotal,
  }) : super._(
         id: id,
         purchaseId: purchaseId,
         productId: productId,
         productName: productName,
         quantity: quantity,
         unitPurchasePrice: unitPurchasePrice,
         lineTotal: lineTotal,
       );

  /// Returns a shallow copy of this [PurchaseItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PurchaseItem copyWith({
    Object? id = _Undefined,
    int? purchaseId,
    int? productId,
    String? productName,
    int? quantity,
    double? unitPurchasePrice,
    double? lineTotal,
  }) {
    return PurchaseItem(
      id: id is int? ? id : this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPurchasePrice: unitPurchasePrice ?? this.unitPurchasePrice,
      lineTotal: lineTotal ?? this.lineTotal,
    );
  }
}
