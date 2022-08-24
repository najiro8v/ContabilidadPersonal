import "package:sqflite/sqflite.dart";
import "package:contabilidad/models/models.dart";
import "package:path/path.dart";

class Db {
  static Future<Database> _openDb() async {
    return openDatabase(join(await getDatabasesPath(), 'gastos.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE  finance(id INTEGER PRIMARY KEY, name TEXT, price REAL, desc TEXT)");
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

  static Future<List<ExpensesAndFinance>> getAll(
      ExpensesAndFinance expenses) async {
    Database database = await _openDb();
    final List<Map<String, dynamic>> expensesMap =
        await database.query("finance");
  }
}
