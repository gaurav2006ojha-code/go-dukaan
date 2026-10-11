import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class CustomerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Customer>> getCustomers(Session session) async {
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

    return await Customer.db.find(
      session,
      where: (t) => t.shopId.equals(shop.id!),
      orderBy: (t) => t.name,
    );
  }

  Future<Customer?> getCustomer(
    Session session,
    int customerId,
  ) async {
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

    final customer = await Customer.db.findById(
      session,
      customerId,
    );

    if (customer == null || customer.shopId != shop.id) {
      return null;
    }

    return customer;
  }

  Future<Customer> createCustomer(
    Session session, {
    required String name,
    String? mobile,
    String? email,
    String? address,
  }) async {
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

    final now = DateTime.now();

    final customer = Customer(
      shopId: shop.id!,
      name: name,
      mobile: mobile,
      email: email,
      address: address,
      totalDue: 0,
      totalPaid: 0,
      createdAt: now,
      updatedAt: now,
    );

    return await Customer.db.insertRow(
      session,
      customer,
    );
  }

  Future<Customer> updateCustomer(
    Session session, {
    required int customerId,
    required String name,
    String? mobile,
    String? email,
    String? address,
  }) async {
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

    final customer = await Customer.db.findById(
      session,
      customerId,
    );

    if (customer == null || customer.shopId != shop.id) {
      throw Exception('Customer not found.');
    }

    final updatedCustomer = customer.copyWith(
      name: name,
      mobile: mobile,
      email: email,
      address: address,
      updatedAt: DateTime.now(),
    );

    return await Customer.db.updateRow(
      session,
      updatedCustomer,
    );
  }

  Future<void> deleteCustomer(
    Session session,
    int customerId,
  ) async {
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

    final customer = await Customer.db.findById(
      session,
      customerId,
    );

    if (customer == null || customer.shopId != shop.id) {
      throw Exception('Customer not found.');
    }

    await Customer.db.deleteRow(
      session,
      customer,
    );
  }

  Future<List<Customer>> searchCustomers(
    Session session,
    String query,
  ) async {
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

    final search = query.trim();

    if (search.isEmpty) {
      return getCustomers(session);
    }

    return await Customer.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shop.id!) &
          (t.name.ilike('%$search%') | t.mobile.ilike('%$search%')),
      orderBy: (t) => t.name,
    );
  }
}
