import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';
import '../models/stock_movement.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> getDB() async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'stock_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create products table
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            category TEXT,
            unit TEXT,
            b2bPrice REAL,
            baseB2cPrice REAL,
            stockQty INTEGER,
            notes TEXT
          )
        ''');

        // Create stock movements table
        await db.execute('''
          CREATE TABLE stock_movements (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER,
            quantity INTEGER,
            type TEXT,
            date TEXT,
            notes TEXT,
            FOREIGN KEY(productId) REFERENCES products(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // Insert product
  static Future<int> insertProduct(Product product) async {
    final db = await getDB();
    return await db.insert('products', product.toMap());
  }

  // Fetch all products
  static Future<List<Product>> getProducts() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  // Update product
  static Future<int> updateProduct(Product product) async {
    final db = await getDB();
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Delete product
  static Future<int> deleteProduct(int id) async {
    final db = await getDB();
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Insert stock movement + adjust stock
  static Future<int> insertStockMovement(StockMovement movement) async {
    final db = await getDB();

    // Insert movement
    int result = await db.insert('stock_movements', movement.toMap());

    // Update product stock
    if (movement.type == "in") {
      await db.rawUpdate(
        "UPDATE products SET stockQty = stockQty + ? WHERE id = ?",
        [movement.quantity, movement.productId],
      );
    } else if (movement.type == "out") {
      await db.rawUpdate(
        "UPDATE products SET stockQty = stockQty - ? WHERE id = ?",
        [movement.quantity, movement.productId],
      );
    }

    return result;
  }

  // Get all stock movements for a product
  static Future<List<StockMovement>> getStockMovements(int productId) async {
    final db = await getDB();
    final maps = await db.query(
      'stock_movements',
      where: 'productId = ?',
      whereArgs: [productId],
      orderBy: 'date DESC',
    );

    return List.generate(maps.length, (i) {
      return StockMovement.fromMap(maps[i]);
    });
  }
}
