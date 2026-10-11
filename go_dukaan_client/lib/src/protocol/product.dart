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

abstract class Product
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Product._({
    this.id,
    required this.shopId,
    required this.name,
    this.sku,
    this.barcode,
    required this.category,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stockQuantity,
    required this.lowStockAlert,
    required this.unit,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product({
    int? id,
    required int shopId,
    required String name,
    String? sku,
    String? barcode,
    required String category,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQuantity,
    required int lowStockAlert,
    required String unit,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductImpl;

  factory Product.fromJson(Map<String, dynamic> jsonSerialization) {
    return Product(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      name: jsonSerialization['name'] as String,
      sku: jsonSerialization['sku'] as String?,
      barcode: jsonSerialization['barcode'] as String?,
      category: jsonSerialization['category'] as String,
      purchasePrice: (jsonSerialization['purchasePrice'] as num).toDouble(),
      sellingPrice: (jsonSerialization['sellingPrice'] as num).toDouble(),
      stockQuantity: jsonSerialization['stockQuantity'] as int,
      lowStockAlert: jsonSerialization['lowStockAlert'] as int,
      unit: jsonSerialization['unit'] as String,
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
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

  String name;

  String? sku;

  String? barcode;

  String category;

  double purchasePrice;

  double sellingPrice;

  int stockQuantity;

  int lowStockAlert;

  String unit;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Product copyWith({
    int? id,
    int? shopId,
    String? name,
    String? sku,
    String? barcode,
    String? category,
    double? purchasePrice,
    double? sellingPrice,
    int? stockQuantity,
    int? lowStockAlert,
    String? unit,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Product',
      if (id != null) 'id': id,
      'shopId': shopId,
      'name': name,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      'category': category,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'stockQuantity': stockQuantity,
      'lowStockAlert': lowStockAlert,
      'unit': unit,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Product',
      if (id != null) 'id': id,
      'shopId': shopId,
      'name': name,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      'category': category,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'stockQuantity': stockQuantity,
      'lowStockAlert': lowStockAlert,
      'unit': unit,
      'isActive': isActive,
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

class _ProductImpl extends Product {
  _ProductImpl({
    int? id,
    required int shopId,
    required String name,
    String? sku,
    String? barcode,
    required String category,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQuantity,
    required int lowStockAlert,
    required String unit,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         shopId: shopId,
         name: name,
         sku: sku,
         barcode: barcode,
         category: category,
         purchasePrice: purchasePrice,
         sellingPrice: sellingPrice,
         stockQuantity: stockQuantity,
         lowStockAlert: lowStockAlert,
         unit: unit,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Product copyWith({
    Object? id = _Undefined,
    int? shopId,
    String? name,
    Object? sku = _Undefined,
    Object? barcode = _Undefined,
    String? category,
    double? purchasePrice,
    double? sellingPrice,
    int? stockQuantity,
    int? lowStockAlert,
    String? unit,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      sku: sku is String? ? sku : this.sku,
      barcode: barcode is String? ? barcode : this.barcode,
      category: category ?? this.category,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      lowStockAlert: lowStockAlert ?? this.lowStockAlert,
      unit: unit ?? this.unit,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
