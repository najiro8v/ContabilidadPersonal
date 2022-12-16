import 'package:contabilidad/models/query_option.dart';
import "package:sqflite/sqflite.dart";
// ignore: depend_on_referenced_packages
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
        version: 5, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase('finance.db');

  _createDB(Database db, int version) async {
    /*Catetory Table */
    String categoryTB = "CREATE TABLE IF NOT EXISTS Category (";
    categoryTB += "Id_Category INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
    categoryTB += "name TEXT NOT NULL,";
    categoryTB += "key TEXT NOT NULL UNIQUE";
    categoryTB += ")";
    await db.execute(categoryTB);
    /**Values default */
    await db.execute("INSERT INTO Category(name,key) values('Gastos','gto')");
    await db.execute("INSERT INTO Category(name,key) values('Ingresos','ing')");
    await db
        .execute("INSERT INTO Category(name,key) values('Transporte','trans')");

    /*** */

    /*Type Table */
    String typeTB = "CREATE TABLE IF NOT EXISTS Type (";
    typeTB += "Id_Type INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
    typeTB += "name TEXT NOT NULL";
    typeTB += ")";
    await db.execute(typeTB);
    /**Values default */
    await db.execute("INSERT INTO Type (name) values('Debito')");
    await db.execute("INSERT INTO Type (name) values('Crédito')");
    /*** */
    /*Entry Table */
    String entryTB = "CREATE TABLE IF NOT EXISTS Entry (";
    entryTB += "Id_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
    entryTB += "category_id INTEGER ,";
    entryTB += "name TEXT NOT NULL,";
    entryTB += "key TEXT NOT NULL UNIQUE,";
    entryTB += "value REAL NOT NULL,";
    entryTB +=
        "FOREIGN KEY (category_id) REFERENCES Category (Id_Category) ON DELETE SET NULL ON UPDATE NO ACTION";
    entryTB += ")";
    await db.execute(entryTB);
    /**Values default */
    await db.execute(
        "INSERT INTO Entry(category_id,name,key,value) values(1,'','gto0',0)");
    await db.execute(
        "INSERT INTO Entry(category_id,name,key,value) values(1,'Gatos diarios','gto1',0)");

    //
    await db.execute(
        "INSERT INTO Entry(category_id,name,key,value) values(2,'','ing0',0)");
    await db.execute(
        "INSERT INTO Entry(category_id,name,key,value) values(2,'Ingresos diarios','ing1',0)");
    //
    await db.execute(
        "INSERT INTO Entry(category_id,name,key,value) values(3,'','trans0',395)");
    await db.execute(
        "INSERT INTO Entry(category_id,name,key,value) values(3,'Bus Lomas','trans1',395)");
    /*** */

    /*ValueEntry Table */
    String valueEntryTB = "CREATE TABLE IF NOT EXISTS Value_Entry (";
    valueEntryTB +=
        "Id_Value_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
    valueEntryTB += "entry_id INTEGER ,";
    valueEntryTB += "type_id INTEGER ,";
    valueEntryTB += "desc TEXT NOT NULL,";
    valueEntryTB += "value REAL NOT NULL,";
    valueEntryTB += "date INTEGER NOT NULL,";
    valueEntryTB += "latitud INTEGER ,";
    valueEntryTB += "length INTEGER,";
    valueEntryTB +=
        "FOREIGN KEY (entry_id) REFERENCES Entry (Id_Entry) ON DELETE SET NULL ON UPDATE NO ACTION,";
    valueEntryTB +=
        "FOREIGN KEY (type_id) REFERENCES Type (Id_Type) ON DELETE SET NULL ON UPDATE NO ACTION";
    valueEntryTB += ")";
    await db.execute(valueEntryTB);
    /**Values default */
    /*** */
  }

  _upgradeDB(Database db, int oldVersion, int version) async {
    /*Catetory Table */
    if (oldVersion < version) {
      /*Catetory Table */
      String categoryTB = "CREATE TABLE IF NOT EXISTS Category (";
      categoryTB += "Id_Category INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      categoryTB += "name TEXT NOT NULL,";
      categoryTB += "key TEXT NOT NULL UNIQUE";
      categoryTB += ")";
      await db.execute(categoryTB);
      /**Values default */
      /*await db.execute("INSERT INTO Category(name,key) values('Gastos','gto')");
      await db
          .execute("INSERT INTO Category(name,key) values('Ingresos','ing')");
      await db.execute(
          "INSERT INTO Category(name,key) values('Transporte','trans')");

      ** */

      /*Type Table */
      String typeTB = "CREATE TABLE IF NOT EXISTS Type (";
      typeTB += "Id_Type INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      typeTB += "name TEXT NOT NULL";
      typeTB += ")";
      await db.execute(typeTB);
      /**Values default */
      /* await db.execute("INSERT INTO Type (name) values('Debito')");
      await db.execute("INSERT INTO Type (name) values('Crédito')");
      ** */
      /*Entry Table */
      String entryTB = "CREATE TABLE IF NOT EXISTS Entry (";
      entryTB += "Id_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      entryTB += "category_id INTEGER ,";
      entryTB += "name TEXT NOT NULL,";
      entryTB += "key TEXT NOT NULL UNIQUE,";
      entryTB += "value REAL NOT NULL,";
      entryTB +=
          "FOREIGN KEY (category_id) REFERENCES Category (Id_Category) ON DELETE SET NULL ON UPDATE NO ACTION";
      entryTB += ")";
      await db.execute(entryTB);

      /**Values default */
      /*await db.execute(
          "INSERT INTO Entry(category_id,name,key,value) values(1,'Gatos diarios','gto1',0)");
      await db.execute(
          "INSERT INTO Entry(category_id,name,key,value) values(2,'Ingresos diarios','ing1',0)");
      await db.execute(
          "INSERT INTO Entry(category_id,name,key,value) values(3,'Bus Lomas','trans1',395)");
      * */

      /*ValueEntry Table */
      String valueEntryTB = "CREATE TABLE IF NOT EXISTS Value_Entry (";
      valueEntryTB +=
          "Id_Value_Entry INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,";
      valueEntryTB += "entry_id INTEGER ,";
      valueEntryTB += "type_id INTEGER ,";
      valueEntryTB += "desc TEXT NOT NULL,";
      valueEntryTB += "value REAL NOT NULL,";
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

  static Future<int> insert(String dbName, dynamic model) async {
    Database database = await instance.database;

    final response = await database.insert(dbName, model.toMap());

    return response;
  }

  static Future<int> delete(String dbName,
      {required int id, required String idName}) async {
    Database database = await instance.database;
    return await database.delete(dbName, where: "$idName = ?", whereArgs: [id]);
  }

  static Future<void> update(String dbName, dynamic model,
      {required int id, required String idName}) async {
    Database database = await instance.database;
    await database
        .update(dbName, model.toMap(), where: "$idName = ?", whereArgs: [id]);
  }

  static Future<List<dynamic>> get(String dbName,
      {String query = "", QueryOption? queryOption}) async {
    Database database = await instance.database;

    final List<Map<String, dynamic>> result =
        query.isEmpty && queryOption == null
            ? await database.query(dbName)
            : queryOption != null
                ? await database.query(dbName,
                    columns: queryOption.columns,
                    distinct: queryOption.distinct,
                    groupBy: queryOption.groupBy,
                    having: queryOption.having,
                    limit: queryOption.limit,
                    offset: queryOption.offset,
                    orderBy: queryOption.orderBy,
                    where: queryOption.where,
                    whereArgs: queryOption.whereArgs)
                : await database.rawQuery(query);

    return result.toList();
  }
}
