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
import 'package:go_dukaan_client/src/protocol/protocol.dart' as _i6qck55r;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class Shop
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Shop._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.shopName,
    required this.ownerName,
    required this.businessType,
    required this.mobile,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shop({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String shopName,
    required String ownerName,
    required String businessType,
    required String mobile,
    required String city,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ShopImpl;

  factory Shop.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shop(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i6qck55r.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      shopName: jsonSerialization['shopName'] as String,
      ownerName: jsonSerialization['ownerName'] as String,
      businessType: jsonSerialization['businessType'] as String,
      mobile: jsonSerialization['mobile'] as String,
      city: jsonSerialization['city'] as String,
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

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

  String shopName;

  String ownerName;

  String businessType;

  String mobile;

  String city;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Shop copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? shopName,
    String? ownerName,
    String? businessType,
    String? mobile,
    String? city,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'shopName': shopName,
      'ownerName': ownerName,
      'businessType': businessType,
      'mobile': mobile,
      'city': city,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'shopName': shopName,
      'ownerName': ownerName,
      'businessType': businessType,
      'mobile': mobile,
      'city': city,
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

class _ShopImpl extends Shop {
  _ShopImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String shopName,
    required String ownerName,
    required String businessType,
    required String mobile,
    required String city,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         shopName: shopName,
         ownerName: ownerName,
         businessType: businessType,
         mobile: mobile,
         city: city,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Shop copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? shopName,
    String? ownerName,
    String? businessType,
    String? mobile,
    String? city,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Shop(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      shopName: shopName ?? this.shopName,
      ownerName: ownerName ?? this.ownerName,
      businessType: businessType ?? this.businessType,
      mobile: mobile ?? this.mobile,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
