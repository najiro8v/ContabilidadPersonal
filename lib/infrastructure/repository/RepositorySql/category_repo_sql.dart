import 'package:contabilidad/domain/entities/models/models.dart'
    show Category, Entry, QueryOption, ValueEntry;
import 'package:contabilidad/infrastructure/helppers/sql/helppers_category_sql.dart';
import '../../datasources/sql_lite_datasources.dart';

class CategorySQLImplement {
  static const String dbName = "Category";
  static const String idName = "Id_Category";
  final sqlPool =
      SqlLiteDataSource<Category>(dbName: dbName, fromMap: Category.fromMap);

  Future<List<Category>> find({Category? entity}) async {
    final queryOption = HelppersCategorySQL.objectToQuery(entity, dbName);
    final list = await sqlPool.getAll(queryOption: queryOption);
    return list;
  }

  Future<Category> insert({required Category entity}) async {
    final list = await sqlPool.add(entity);
    return list;
  }

  Future<Category> findUpdate({required Category entity}) async {
    final list = await sqlPool.findUpdate(entity, idName);
    return list;
  }
}

class ValueEntrySQLImplement {
  static const String dbName = "Value_Entry";
  static const String idName = "Id_Value_Entry";
  final sqlPool = SqlLiteDataSource<ValueEntry>(
      dbName: dbName, fromMap: ValueEntry.fromMap);

  Future<List<ValueEntry>> find({ValueEntry? entity}) async {
    final queryOption = HelppersCategorySQL.objectToQuery(entity, dbName);
    final list = await sqlPool.getAll(queryOption: queryOption);
    return list;
  }

  Future<ValueEntry> insert({required ValueEntry entity}) async {
    final list = await sqlPool.add(entity);
    return list;
  }

  Future<List<ValueEntry>> getByEntry(
      {QueryOption? queryOption, required List<int> id}) async {
    String listId = id.join(",");
    String query =
        'select t0.*, T1.name AS entryName, t2.name AS categoryName from $dbName as T0';
    query +=
        "  INNER JOIN ${EntrySQLImplement.dbName} as T1 on T0.entry_id = T1.${EntrySQLImplement.idName}";
    query +=
        "  INNER JOIN ${CategorySQLImplement.dbName}  as T2 on T2.${EntrySQLImplement.idName} = T1.category_id";
    query += "  where T0.entry_id in ($listId) ORDER BY t0.name";
    return await sqlPool.getAll(query: query);
  }

  Future<ValueEntry> findUpdate({required ValueEntry entity}) async {
    final obj = await sqlPool.findUpdate(entity, idName);
    return obj;
  }

  Future<bool> remove({required int id}) async {
    final resp = await sqlPool.remove(id, idName);
    return resp;
  }
}

class EntrySQLImplement {
  static const String dbName = "Entry";
  static const String idName = "Id_Entry";
  final sqlPool =
      SqlLiteDataSource<Entry>(dbName: dbName, fromMap: Entry.fromMap);

  Future<List<Entry>> find({Entry? entity}) async {
    final queryOption = HelppersCategorySQL.objectToQuery(entity, dbName);
    final list = await sqlPool.getAll(queryOption: queryOption);
    return list;
  }

  Future<Entry> insert({required Entry entity}) async {
    final list = await sqlPool.add(entity);
    return list;
  }

  Future<List<Entry>> readData({QueryOption? queryOption}) async {
    String query =
        "select T0.Id_Entry,t0.value, t0.category_id, t0.key, t0.name, T1.key as categoryKey from $dbName as T0 INNER JOIN ${CategorySQLImplement.dbName} T1 ON T1.Id_Category = T0.category_id ORDER BY t0.name";
    return await sqlPool.getAll(query: query);
  }

  Future<List<Entry>> getByCategory(
      {QueryOption? queryOption, required List<int> id}) async {
    String listId = id.join(",");
    String query =
        "select t0.Id_Entry,t0.value, t0.category_id, t0.key, t0.name from $dbName as T0 where T0.category_id in ($listId) ORDER BY t0.name";
    return await sqlPool.getAll(query: query);
  }

  Future<Entry> findUpdate({required Entry entity}) async {
    final obj = await sqlPool.findUpdate(entity, idName);
    return obj;
  }

  Future<bool> remove({required int id}) async {
    final resp = await sqlPool.remove(id, idName);
    return resp;
  }
}
