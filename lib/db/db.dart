import "package:sqflite/sqflite.dart";
import "package:contabilidad/models/models.dart";
import 'package:path/path.dart';

class DatabaseSQL {
  static final DatabaseSQL instance = DatabaseSQL._init();
  static Database? _database;
  DatabaseSQL._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('finance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 4, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase('finance.db');

  static _deleteDB() async {
    await deleteDatabase('finance.db');
  }

  _createDB(Database db, int version) async {
    /*Catetory Table */
    String categoryTB = "CREATE TABLE Category (";
    categoryTB += "Id_Category INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
    categoryTB += "name TEXT NOT NULL,";
    categoryTB += "key TEXT NOT NULL";
    categoryTB += ")";
    await db.execute(categoryTB);

    /*Type Table */
    String typeTB = "CREATE TABLE Type (";
    typeTB += "Id_Type INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
    typeTB += "name TEXT NOT NULL";
    typeTB += ")";
    await db.execute(typeTB);

    /*Entry Table */
    String entryTB = "CREATE TABLE Entry (";
    entryTB += "Id_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
    entryTB += "category_id INTEGER ,";
    entryTB += "name TEXT NOT NULL,";
    entryTB += "key TEXT NOT NULL,";
    entryTB += "value REAL NOT NULL,";
    entryTB +=
        "FOREIGN KEY (category_id) REFERENCES Category (Id_Category) ON DELETE SET NULL ON UPDATE NO ACTION";
    entryTB += ")";
    await db.execute(entryTB);

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
        "FOREIGN KEY (entry_id) REFERENCES Entry (Id_Entry) ON DELETE SET NULL ON UPDATE NO ACTION,";
    valueEntryTB +=
        "FOREIGN KEY (type_id) REFERENCES Type (Id_Type) ON DELETE SET NULL ON UPDATE NO ACTION";
    valueEntryTB += ")";
    await db.execute(valueEntryTB);
  }

  _upgradeDB(Database db, int oldVersion, int version) async {
    /*Catetory Table */
    if (oldVersion < version) {
      String categoryTB = "CREATE TABLE Category (";
      categoryTB += "Id_Category INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      categoryTB += "name TEXT NOT NULL,";
      categoryTB += "key TEXT NOT NULL";
      categoryTB += ")";
      await db.execute(categoryTB);

      /*Type Table */
      String typeTB = "CREATE TABLE Type (";
      typeTB += "Id_Type INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      typeTB += "name TEXT NOT NULL";
      typeTB += ")";
      await db.execute(typeTB);

      /*Entry Table */
      String entryTB = "CREATE TABLE Entry (";
      entryTB += "Id_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      entryTB += "category_id INTEGER ,";
      entryTB += "name TEXT NOT NULL,";
      entryTB += "key TEXT NOT NULL,";
      entryTB += "value REAL NOT NULL,";
      entryTB +=
          "FOREIGN KEY (category_id) REFERENCES Category (Id_Category) ON DELETE SET NULL ON UPDATE NO ACTION";
      entryTB += ")";
      await db.execute(entryTB);

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
          "FOREIGN KEY (entry_id) REFERENCES Entry (Id_Entry) ON DELETE SET NULL ON UPDATE NO ACTION,";
      valueEntryTB +=
          "FOREIGN KEY (type_id) REFERENCES Type (Id_Type) ON DELETE SET NULL ON UPDATE NO ACTION";
      valueEntryTB += ")";
      await db.execute(valueEntryTB);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  static Future<void> insert(String dbName, dynamic model) async {
    Database database = await instance.database;
    database.insert(dbName, model.toMap());
  }

  static Future<void> delete(String dbName, dynamic model) async {
    Database database = await instance.database;
    database.delete(dbName, where: "id = ?", whereArgs: [model.id]);
  }

  static Future<void> update(String dbName, dynamic model) async {
    Database database = await instance.database;
    database
        .update(dbName, model.toMap(), where: "id = ?", whereArgs: [model.id]);
  }

  static Future<List<dynamic>> get(String dbName, {String query = ""}) async {
    Database database = await instance.database;
    if (query.isEmpty) query = dbName;
    final List<Map<String, dynamic>> result = await database.query(query);
    return result.toList();
  }
}
