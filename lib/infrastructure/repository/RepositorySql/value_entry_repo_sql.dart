import 'package:contabilidad/domain/entities/models/models.dart'
    show QueryOption, ValueEntry;
import 'package:contabilidad/infrastructure/helppers/sql/helppers_category_sql.dart';
import 'package:contabilidad/infrastructure/repository/RepositorySql/category_repo_sql.dart';
import 'package:contabilidad/infrastructure/repository/RepositorySql/entry_repo_sql.dart';
import 'package:contabilidad/infrastructure/datasources/sql/sql_lite_datasources.dart';

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
    String query =
        'select t0.*, T1.name AS entryName, t2.name AS categoryName from $dbName as T0';
    query +=
        "  INNER JOIN ${EntrySQLImplement.dbName} as T1 on T0.entry_id = T1.${EntrySQLImplement.idName}";
    query +=
        "  INNER JOIN ${CategorySQLImplement.dbName}  as T2 on T2.${CategorySQLImplement.idName} = T1.category_id";
    if (id.isNotEmpty) {
      String args = "?";
      for (var i = 0; i < id.length - 1; i++) {
        args += ",?";
      }
      query += "  where T0.entry_id in ($args) ORDER BY t0.desc";
    }
    return await sqlPool.getAll(
        query: query, args: id.isEmpty ? null : [...id]);
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
