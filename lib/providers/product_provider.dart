import 'package:flutter/material.dart';
import '../models/product.dart';
import '../db/db_helper.dart';
import '../models/stock_movement.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    _products = await DBHelper.getProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await DBHelper.insertProduct(product);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await DBHelper.updateProduct(product);
    await loadProducts(); // reload products from DB
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    await DBHelper.deleteProduct(id);
    await loadProducts();
  }

  // New method: add stock movement
  Future<void> addStockMovement(int productId, int quantity, String type, {String? note}) async {
  final movement = StockMovement(
    productId: productId,
    type: type,
    quantity: quantity,
    date: DateTime.now().toIso8601String(),
    note: note ?? "",
  );

  // Insert into DB
  await DBHelper.insertStockMovement(movement);

  // Reload products to update stockQty
  await loadProducts(); // this already calls notifyListeners()
}

}
