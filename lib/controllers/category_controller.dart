import 'package:contabilidad/models/models.dart' show Category;
import "package:contabilidad/db/db.dart";

class CategoryController {
  static const String dbName = "Category";
  static Future<List<Category>> get() async {
    List<dynamic> listado = await DatabaseSQL.get(dbName);
    return List.generate(
        listado.length,
        (i) => Category(
            key: listado[i]['key'],
            name: listado[i]['name'],
            id: listado[i]['Id_Category']));
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
}
