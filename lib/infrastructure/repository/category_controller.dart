import 'package:contabilidad/domain/entities/models/expenses_and_finance.dart';
import 'package:contabilidad/domain/entities/models/models.dart'
    show QueryOption;
import '../datasources/sql_lite_datasources.dart';
import 'RepositorySql/category_repo_sql.dart';

class CategoryController {
  final datasource = CategorySQLImplement();

  Future<List<Category>> find({Category? entity}) async {
    return await datasource.find(entity: entity);
  }

  Future<Category> insert({required Category entity}) async {
    return await datasource.insert(entity: entity);
  }

  Future<Category> findUpdate({required Category entity}) async {
    return await datasource.findUpdate(entity: entity);
  }
}

class ValueEntryController {
  final datasource = ValueEntrySQLImplement();

  Future<List<ValueEntry>> find({ValueEntry? entity}) async {
    return await datasource.find(entity: entity);
  }

  Future<ValueEntry> insert({required ValueEntry entity}) async {
    return await datasource.insert(entity: entity);
  }
}

class EntryController {
  final datasource = EntrySQLImplement();

  Future<List<Entry>> find({Entry? entity}) async {
    return await datasource.find(entity: entity);
  }

  Future<Entry> insert({required Entry entity}) async {
    return await datasource.insert(entity: entity);
  }

  Future<List<Entry>> findByCategory({required List<int> id}) async {
    return await datasource.getByCategory(id: id);
  }

  Future<Entry> findUpdate({required Entry entity}) async {
    return await datasource.findUpdate(entity: entity);
  }

  Future<bool> remove({required int id}) async {
    return await datasource.remove(id: id);
  }
}

class EntryController1 {
  static const String dbName = "Entry";
  final sqlPool =
      SqlLiteDataSource<Entry>(dbName: dbName, fromMap: Entry.fromMap);

  Future<List<Entry>> readData({QueryOption? queryOption}) async {
    String query =
        "select T0.Id_Entry,t0.value, t0.category_id, t0.key, t0.name, T1.key as categoryKey from $dbName as T0 INNER JOIN ${CategorySQLImplement.dbName} T1 ON T1.Id_Category = T0.category_id ORDER BY t0.name";
    return await sqlPool.getAll(query: query);
  }

  Future<List<Entry>> getByCategory(
      {QueryOption? queryOption, required int id}) async {
    String query =
        "select t0.Id_Entry,t0.value, t0.category_id, t0.key, t0.name from $dbName as T0 where T0.category_id = $id ORDER BY t0.name";
    return await sqlPool.getAll(query: query);
  }

  Future<Entry> insert(Entry entry) async {
    return await sqlPool.add(entry);
  }
}






/*
class CategoryController {
  static const String dbName = "Category";
  static Future<List<Category>> get() async {
    final repo = SqlLiteDataSource<Category>(dbName: dbName);
    await repo.add(Category(name: "name", key: "key"));
    /*List<dynamic> listado = await DatabaseSQL.get(dbName);
    return List.generate(
        listado.length,
        (i) => Category(
            key: listado[i]['key'],
            name: listado[i]['name'],
            id: listado[i]['Id_Category'],
            enable: listado[i]['enable'] == 1 ? true : false));*/
  }

  static Future<int> insert(Category category) async {
    return await DatabaseSQL.insert(dbName, category);
  }

  static Future<int> getId(Category category) async {
    String query =
        "select T0.Id_Category from $dbName T0 where T0.key = '${category.key}'";
    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return listado.first.row[0];
  }

  static Future<int> updateCategory(Category category) async {
    int update = await DatabaseSQL.update(dbName, category,
        id: category.id!, idName: 'Id_Category');
    return update;
  }
}
*/