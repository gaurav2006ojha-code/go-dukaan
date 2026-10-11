import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class ShopEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Current logged-in user's shop
  Future<Shop?> getMyShop(Session session) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('User is not authenticated.');
    }

    return await Shop.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
  }

  /// Create or update current user's shop
  Future<Shop> saveShop(
    Session session, {
    required String shopName,
    required String ownerName,
    required String businessType,
    required String mobile,
    required String city,
  }) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('User is not authenticated.');
    }

    final existingShop = await Shop.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    final now = DateTime.now();

    if (existingShop != null) {
      final updatedShop = existingShop.copyWith(
        shopName: shopName,
        ownerName: ownerName,
        businessType: businessType,
        mobile: mobile,
        city: city,
        updatedAt: now,
      );

      return await Shop.db.updateRow(
        session,
        updatedShop,
      );
    }

    final shop = Shop(
      authUserId: authUserId,
      shopName: shopName,
      ownerName: ownerName,
      businessType: businessType,
      mobile: mobile,
      city: city,
      createdAt: now,
      updatedAt: now,
    );

    return await Shop.db.insertRow(
      session,
      shop,
    );
  }
}