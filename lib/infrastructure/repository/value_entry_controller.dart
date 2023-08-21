import 'package:contabilidad/domain/entities/models/models.dart'
    show QueryOption, ValueEntry;
import 'package:contabilidad/infrastructure/datasources/db/db.dart';
import 'category_controller.dart';
import 'entry_controller.dart';

class ValueEntryController {
  static const String dbName = "Value_Entry";

  static Future<List<ValueEntry>> get() async {
    String query =
        'select t0.*, T1.name AS entryName, t2.name AS categoryName from $dbName as T0';
    query +=
        "  INNER JOIN ${EntryController.dbName} as T1 on T0.entry_id = T1.Id_Entry";
    query +=
        "  INNER JOIN ${CategoryController.dbName}  as T2 on T2.Id_Category = T1.category_id";
    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return List.generate(
        listado.length,
        (i) => ValueEntry(
              value: listado[i]['value'],
              date: listado[i]['date'],
              entryName: listado[i]['entryName'],
              type: listado[i]['type_id'],
              categoryName: listado[i]['categoryName'],
              entry: listado[i]['entry_id'],
              desc: listado[i]['desc'],
              length: 1,
              latitud: 1,
              id: listado[i]['Id_Value_Entry'],
            ));
  }

  static Future<List<dynamic>> getChartCount() async {
    String query =
        'select t0.*, T1.name AS entryName, t2.name AS categoryName from $dbName as T0';

    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return List.generate(
        listado.length,
        (i) => ValueEntry(
              value: listado[i]['value'],
              date: listado[i]['date'],
              entryName: listado[i]['entryName'],
              type: listado[i]['type_id'],
              categoryName: listado[i]['categoryName'],
              entry: listado[i]['entry_id'],
              desc: listado[i]['desc'],
              length: 1,
              latitud: 1,
              id: listado[i]['Id_Value_Entry'],
            ));
  }

  static Future<int> insert(ValueEntry value) async {
    return await DatabaseSQL.insert(dbName, value);
  }

  static Future<int> delete(int id) async {
    int delete =
        await DatabaseSQL.delete(dbName, id: id, idName: "Id_Value_Entry");
    if (delete < 0) {
      throw Error();
    }
    return delete;
  }

  static Future<int> update(ValueEntry value, int id) async {
    return await DatabaseSQL.update(dbName, value,
        id: id, idName: "Id_Value_Entry");
  }

  static Future<List<dynamic>> getBy({required QueryOption queryOption}) async {
    List<dynamic> listado =
        await DatabaseSQL.get(dbName, queryOption: queryOption);
    var data = List.generate(listado.length, (i) {
      var temp = {};

      for (var element in queryOption.columns!) {
        for (var key in listado[i].keys) {
          if (element == key) {
            if (element == "Id_Value_Entry") {
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
}
