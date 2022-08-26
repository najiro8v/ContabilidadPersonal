import 'package:idb_sqflite/idb_sqflite.dart';
import "package:sqflite/sqflite.dart";
import "package:contabilidad/models/models.dart";
import "package:path/path.dart";
import "package:idb_shim/idb.dart" as idb;

class DatabaseSQL {
  static const String _nameDb = "gastos.db";
  static Future<idb.Database> _openDb() async {
    var factory = getIdbFactorySqflite(databaseFactory);
    return factory.open(
      _nameDb,
      version: 1,
      onUpgradeNeeded: (VersionChangeEvent event) {
        idb.Database db = event.database;
      },
    );
  }

  static Future<void> insert(ExpensesAndFinance expenses) async {
    idb.Database db = await _openDb();
    idb.Transaction tx = db.transaction(_nameDb, idbModeReadWrite);
    idb.ObjectStore store = tx.objectStore(_nameDb);
    store.getAll()
  }

  static Future<void> delete(ExpensesAndFinance expenses) async {
    Database database = await _openDb();
    idb.delete("finance", where: "id = ?", whereArgs: [expenses.id]);
  }

  static Future<void> update(ExpensesAndFinance expenses) async {
    Database database = await _openDb();
    idb.update("finance", expenses.toMap(),
        where: "id = ?", whereArgs: [expenses.id]);
  }

  static Future<List<ExpensesAndFinance>> getAll() async {
    Database database = await _openDb();
    final List<Map<String, dynamic>> expensesMap = await idb.query("finance");

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
    await idb.rawQuery(
        " CREATE TABLE finance (id INTEGER PRIMARY KEY, name TEXT, price REAL, desc TEXT,key TEXT)");
  }
}
