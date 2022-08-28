import 'package:contabilidad/models/models.dart' show Category;
import "package:contabilidad/db/db.dart";

class CategoryController {
  static const String dbName = "Category";
  static Future<List<Category>> getCategories() async {
    List<dynamic> listado = await DatabaseSQL.get(dbName);
    return List.generate(listado.length,
        (i) => Category(key: listado[i]['key'], name: listado[i]['name']));
  }

  static Future<void> insertCategorie(Category category) async {
    await DatabaseSQL.insert(dbName, category);
  }
}
