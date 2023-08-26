import 'package:contabilidad/domain/entities/models/models.dart' show Category;
import 'package:contabilidad/infrastructure/datasources/db/db.dart';

import '../datasources/sql_lite_datasources.dart';
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