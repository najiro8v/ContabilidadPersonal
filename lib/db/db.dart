import "package:idb_sqflite/idb_sqflite.dart";
import "package:contabilidad/models/models.dart";
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';

class DatabaseSQL {
  static Future<Database> _openDb() async {
    return openDatabase(join(await getDatabasesPath(), 'gastos.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE finance(id INTEGER PRIMARY KEY, name TEXT, price REAL, desc TEXT,key TEXT)");
    }, version: 1);
  }

  static Future<void> insert(ExpensesAndFinance expenses) async {
    Database database = await _openDb();
    database.insert("finance", expenses.toMap());
  }

  static Future<void> delete(ExpensesAndFinance expenses) async {
    Database database = await _openDb();
    database.delete("finance", where: "id = ?", whereArgs: [expenses.id]);
  }

  static Future<void> update(ExpensesAndFinance expenses) async {
    Database database = await _openDb();
    database.update("finance", expenses.toMap(),
        where: "id = ?", whereArgs: [expenses.id]);
  }

  static Future<List<ExpensesAndFinance>> getAll() async {
    Database database = await _openDb();
    final List<Map<String, dynamic>> expensesMap =
        await database.query("finance");

    return List.generate(
        expensesMap.length,
        (i) => ExpensesAndFinance(
            id: expensesMap[i]['id'],
            key: expensesMap[i]['key'],
            desc: expensesMap[i]['desc'],
            name: expensesMap[i]['name'],
            price: expensesMap[i]['price']));
  }

  static Future<void> dropResest() async {
    Database database = await _openDb();
    await database.rawQuery(
        " CREATE TABLE finance (id INTEGER PRIMARY KEY, name TEXT, price REAL, desc TEXT,key TEXT)");
  }
}
