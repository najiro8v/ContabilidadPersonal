import 'package:contabilidad/models/models.dart' show Entry;
import "package:contabilidad/db/db.dart";
import 'package:contabilidad/models/query_option.dart';
import 'category_controller.dart';

class EntryController {
  static const String dbName = "Entry";

  static Future<List<Entry>> get() async {
    String query =
        "select t0.value, t0.category_id, t0.key, t0.name, T1.key as categoryKey from $dbName as T0 INNER JOIN ${CategoryController.dbName} T1 ON T1.Id_Category = T0.category_id ORDER BY t0.name";
    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return List.generate(
        listado.length,
        (i) => Entry(
            value: listado[i]['value'],
            category: listado[i]['category_id'],
            key: listado[i]['key'],
            name: listado[i]['name'],
            categoryKey: listado[i]['categoryKey'],
            id: listado[i]['Id_Entry']));
  }

  static Future<List<Entry>> getByCategory(String idCategory) async {
    String query =
        "select t0.value, t0.category_id, t0.key, t0.name from $dbName as T0 where T0.category_id = $idCategory ORDER BY t0.name";
    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return List.generate(
        listado.length,
        (i) => Entry(
            value: listado[i]['value'],
            category: listado[i]['category_id'],
            key: listado[i]['key'],
            name: listado[i]['name'],
            id: listado[i]['Id_Entry']));
  }

  static Future<List<dynamic>> getBy({required QueryOption queryOption}) async {
    List<dynamic> listado =
        await DatabaseSQL.get(dbName, queryOption: queryOption);
    var data = List.generate(listado.length, (i) {
      var temp = {};

      for (var element in queryOption.columns!) {
        for (var key in listado[i].keys) {
          if (element == key) {
            if (element == "Id_Entry") {
              temp["id"] = listado[i][key];
            } else {
              temp[element] = listado[i][key];
            }
          }
        }
      }
      return temp;
    });
    return data;
  }

  static Future<int> insert(Entry entry) async {
    return await DatabaseSQL.insert(dbName, entry);
  }

  static Future<int> getId(Entry entry) async {
    String query =
        "select T0.Id_Entry from $dbName T0 where T0.key = '${entry.key}'";
    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return listado.first.row[0];
  }

  static Future<void> update(Entry value, int id) async {
    return await DatabaseSQL.update(dbName, value, id: id, idName: "Id_Entry");
  }

  static Future<void> delete(int id) async {
    var delete = await DatabaseSQL.delete(dbName, id: id, idName: "Id_Entry");
    if (delete < 0) {
      throw Error();
    }
  }
}
