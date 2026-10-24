import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:expenses_app/models/product_model.dart';

class DbHelperProducts {
  Database? myProductsDatabase;

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDatabase = join(directory.path, "ProductosDB.db");
    return openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute("""
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            date TEXT NOT NULL,
            type TEXT NOT NULL
          )
        """);
      }
    );
  }

  Future<void> insertProduct(ProductModel product) async {
    final db = await initDatabase();
    await db.insert("products", {
      "name": product.name,
      "price": product.price,
      "date": product.date,
      "type": product.type,
    });
  }

  Future<List<Map<String, dynamic>>> listProducts() async {
    final db = await initDatabase();
    return db.rawQuery("SELECT * FROM products ORDER BY id DESC");
  }

  Future<void> uppdateProduct(int id, String name) async {
    final db = await initDatabase();
    db.update("products", {"name": name}, where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteProduct(int id) async {
    final db = await initDatabase();
    db.delete("products", where: "id = ?", whereArgs: [id]);
  }
}
