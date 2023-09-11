import 'package:contabilidad/domain/entities/models/expenses_and_finance.dart';
import 'package:contabilidad/domain/entities/models/models.dart'
    show Category, QueryOption;
import '../datasources/sql_lite_datasources.dart';

class CategoryController {
  static const String dbName = "Category";
  final sqlPool =
      SqlLiteDataSource<Category>(dbName: dbName, fromMap: Category.fromMap);

  Future<List<Category>> readData({QueryOption? queryOption}) async {
    final list = await sqlPool.getAll(queryOption: queryOption);
    return list;
  }
}

class EntryController {
  static const String dbName = "Entry";
  final sqlPool =
      SqlLiteDataSource<Entry>(dbName: dbName, fromMap: Entry.fromMap);

  Future<List<Entry>> readData({QueryOption? queryOption}) async {
    String query =
        "select T0.Id_Entry,t0.value, t0.category_id, t0.key, t0.name, T1.key as categoryKey from $dbName as T0 INNER JOIN ${CategoryController.dbName} T1 ON T1.Id_Category = T0.category_id ORDER BY t0.name";
    return await sqlPool.getAll(query: query);
  }

  Future<List<Entry>> getByCategory(
      {QueryOption? queryOption, required int id}) async {
    String query =
        "select t0.Id_Entry,t0.value, t0.category_id, t0.key, t0.name from $dbName as T0 where T0.category_id = $id ORDER BY t0.name";
    return await sqlPool.getAll(query: query);
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