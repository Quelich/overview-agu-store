import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'cart.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE cart_items(id TEXT PRIMARY KEY, title TEXT, price TEXT, imageUrl TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<int> deleteItem(String id) async {
    final db = await DBHelper.database();
    return await db.delete(
      "cart_items",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAllItems() async {
    final db = await DBHelper.database();
    return await db.delete("cart_items");
  }
}
