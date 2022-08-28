import "package:sqflite/sqflite.dart";
import "package:contabilidad/models/models.dart";
import 'package:path/path.dart';

class DatabaseSQL {
  static Future<Database> _openDb(dbName) async {
    return openDatabase(join(await getDatabasesPath(), 'finance.db'),
        onCreate: (db, version) async {
      /*Catetory Table */
      String categoryTB = "CREATE TABLE Category (";
      categoryTB += "Id_Category INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      categoryTB += "name TEXT NOT NULL,";
      categoryTB += "key TEXT NOT NULL";
      categoryTB += ")";
      if (dbName == "Category") return db.execute(categoryTB);

      /*Type Table */
      String typeTB = "CREATE TABLE Type (";
      typeTB += "Id_Type INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      typeTB += "name TEXT NOT NULL,";
      typeTB += ")";
      if (dbName == "Type") return db.execute(typeTB);

      /*Entry Table */
      String entryTB = "CREATE TABLE Entry (";
      entryTB += "Id_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      entryTB += "category_id INTEGER ,";
      entryTB += "name TEXT NOT NULL,";
      entryTB += "key TEXT NOT NULL,";
      entryTB += "value REAL NOT NULL,";
      entryTB +=
          "FOREING KEY (categiry_id) REFERENCES Category (Id_Category) ON DELETE SET NULL ON UPDATE NO ACTION";
      entryTB += ")";
      if (dbName == "Entry ") return db.execute(entryTB);

      /*ValueEntry Table */
      String valueEntryTB = "CREATE TABLE Value_Entry (";
      valueEntryTB +=
          "Id_Value_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      valueEntryTB += "entry_id INTEGER ,";
      valueEntryTB += "type_id INTEGER ,";
      valueEntryTB += "name TEXT NOT NULL,";
      valueEntryTB += "key TEXT NOT NULL,";
      valueEntryTB += "date INTEGER NOT NULL,";
      valueEntryTB += "latitud INTEGER ,";
      valueEntryTB += "length INTEGER,";
      valueEntryTB +=
          "FOREING KEY (entry_id) REFERENCES Entry (Id_Entry) ON DELETE SET NULL ON UPDATE NO ACTION";
      valueEntryTB +=
          "FOREING KEY (type_id) REFERENCES Type (Id_Type) ON DELETE SET NULL ON UPDATE NO ACTION";
      valueEntryTB += ")";
      return db.execute(valueEntryTB);
    }, version: 1);
  }

  static Future<void> insert(String dbName, dynamic model) async {
    Database database = await _openDb(dbName);
    database.insert(dbName, model.toMap());
  }

  static Future<void> delete(String dbName, dynamic model) async {
    Database database = await _openDb(dbName);
    database.delete(dbName, where: "id = ?", whereArgs: [model.id]);
  }

  static Future<void> update(String dbName, dynamic model) async {
    Database database = await _openDb(dbName);
    database
        .update(dbName, model.toMap(), where: "id = ?", whereArgs: [model.id]);
  }

  static Future<List<dynamic>> get(String dbName, {String query = ""}) async {
    Database database = await _openDb(dbName);
    if (query.isEmpty) query = dbName;
    final List<Map<String, dynamic>> result = await database.query(query);
    return result.toList();
  }
}
