import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class ProductEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Product>> getProducts(Session session) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('User is not authenticated.');
    }

    final shop = await Shop.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (shop == null) {
      throw Exception('Shop not found.');
    }

    return await Product.db.find(
      session,
      where: (t) => t.shopId.equals(shop.id!),
      orderBy: (t) => t.name,
    );
  }

  Future<Product> createProduct(
    Session session, {
    required String name,
    String? sku,
    String? barcode,
    required String category,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQuantity,
    required int lowStockAlert,
    required String unit,
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

    final product = Product(
      shopId: shop.id!,
      name: name,
      sku: sku,
      barcode: barcode,
      category: category,
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      stockQuantity: stockQuantity,
      lowStockAlert: lowStockAlert,
      unit: unit,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    return await Product.db.insertRow(
      session,
      product,
    );
  }

  Future<Product> updateProduct(
    Session session, {
    required int productId,
    required String name,
    String? sku,
    String? barcode,
    required String category,
    required double purchasePrice,
    required double sellingPrice,
    required int stockQuantity,
    required int lowStockAlert,
    required String unit,
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

    final product = await Product.db.findById(
      session,
      productId,
    );

    if (product == null || product.shopId != shop.id) {
      throw Exception('Product not found.');
    }

    final updatedProduct = product.copyWith(
      name: name,
      sku: sku,
      barcode: barcode,
      category: category,
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      stockQuantity: stockQuantity,
      lowStockAlert: lowStockAlert,
      unit: unit,
      updatedAt: DateTime.now(),
    );

    return await Product.db.updateRow(
      session,
      updatedProduct,
    );
  }

  Future<void> deleteProduct(
    Session session,
    int productId,
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

    final product = await Product.db.findById(
      session,
      productId,
    );

    if (product == null || product.shopId != shop.id) {
      throw Exception('Product not found.');
    }

    await Product.db.deleteRow(
      session,
      product,
    );
  }

  Future<List<Product>> getLowStockProducts(
    Session session,
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

    return await Product.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shop.id!) & (t.stockQuantity <= t.lowStockAlert),
      orderBy: (t) => t.name,
    );
  }
}
