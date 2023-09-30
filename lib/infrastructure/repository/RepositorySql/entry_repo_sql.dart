import 'package:contabilidad/domain/entities/models/models.dart'
    show Entry, QueryOption;
import 'package:contabilidad/infrastructure/helppers/sql/helppers_category_sql.dart';
import 'package:contabilidad/infrastructure/repository/RepositorySql/category_repo_sql.dart';
import 'package:contabilidad/infrastructure/datasources/sql/sql_lite_datasources.dart';

class EntrySQLImplement {
  static const String dbName = "Entry";
  static const String idName = "Id_Entry";
  final sqlPool =
      SqlLiteDataSource<Entry>(dbName: dbName, fromMap: Entry.fromMap);

  Future<List<Entry>> find({Entry? entity}) async {
    final queryOption = HelppersSQL.objectToQuery(entity?.toMap(), dbName);
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
