import 'package:contabilidad/models/models.dart' show Entry;
import "package:contabilidad/db/db.dart";
import 'category_controller.dart';

class EntryController {
  static const String dbName = "Entry";

  static Future<List<Entry>> get() async {
    String query =
        "select t0.*, T1.key as categoryKey from $dbName as T0 INNER JOIN ${CategoryController.dbName} T1 ON T1.Id_Category = T0.category_id";
    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return List.generate(
        listado.length,
        (i) => Entry(
            value: listado[i]['value'],
            category: listado[i]['category_id'],
            key: listado[i]['key'],
            name: listado[i]['name'],
            categoryKey: listado[i]['categoryKey']));
  }

  static Future<int> insert(Entry entry) async {
    return await DatabaseSQL.insert(dbName, entry);
  }
}
