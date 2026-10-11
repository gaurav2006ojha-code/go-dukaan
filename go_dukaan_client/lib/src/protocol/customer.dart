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

abstract class Customer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Customer._({
    this.id,
    required this.shopId,
    required this.name,
    this.mobile,
    this.email,
    this.address,
    required this.totalDue,
    required this.totalPaid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer({
    int? id,
    required int shopId,
    required String name,
    String? mobile,
    String? email,
    String? address,
    required double totalDue,
    required double totalPaid,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CustomerImpl;

  factory Customer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Customer(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      name: jsonSerialization['name'] as String,
      mobile: jsonSerialization['mobile'] as String?,
      email: jsonSerialization['email'] as String?,
      address: jsonSerialization['address'] as String?,
      totalDue: (jsonSerialization['totalDue'] as num).toDouble(),
      totalPaid: (jsonSerialization['totalPaid'] as num).toDouble(),
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

  String? mobile;

  String? email;

  String? address;

  double totalDue;

  double totalPaid;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Customer copyWith({
    int? id,
    int? shopId,
    String? name,
    String? mobile,
    String? email,
    String? address,
    double? totalDue,
    double? totalPaid,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Customer',
      if (id != null) 'id': id,
      'shopId': shopId,
      'name': name,
      if (mobile != null) 'mobile': mobile,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      'totalDue': totalDue,
      'totalPaid': totalPaid,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Customer',
      if (id != null) 'id': id,
      'shopId': shopId,
      'name': name,
      if (mobile != null) 'mobile': mobile,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      'totalDue': totalDue,
      'totalPaid': totalPaid,
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

class _CustomerImpl extends Customer {
  _CustomerImpl({
    int? id,
    required int shopId,
    required String name,
    String? mobile,
    String? email,
    String? address,
    required double totalDue,
    required double totalPaid,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         shopId: shopId,
         name: name,
         mobile: mobile,
         email: email,
         address: address,
         totalDue: totalDue,
         totalPaid: totalPaid,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Customer copyWith({
    Object? id = _Undefined,
    int? shopId,
    String? name,
    Object? mobile = _Undefined,
    Object? email = _Undefined,
    Object? address = _Undefined,
    double? totalDue,
    double? totalPaid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      mobile: mobile is String? ? mobile : this.mobile,
      email: email is String? ? email : this.email,
      address: address is String? ? address : this.address,
      totalDue: totalDue ?? this.totalDue,
      totalPaid: totalPaid ?? this.totalPaid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
