import 'package:contabilidad/models/models.dart' show ValueEntry;
import "package:contabilidad/db/db.dart";
import 'category_controller.dart';
import 'entry_controller.dart';

class ValueEntryController {
  static const String dbName = "Value_Entry";

  static Future<List<ValueEntry>> get() async {
    String query =
        "select t0.*, T1.name as entryName, t2.name as categoryName from $dbName as T0";
    query +=
        "  INNER JOIN ${EntryController.dbName} T1 as T1 on T0.entry_id = T1.Id_Category";
    query +=
        "  INNER JOIN ${CategoryController.dbName} T2 as T2 on T2.Id_Category = T1.category_id";
    List<dynamic> listado = await DatabaseSQL.get(dbName, query: query);
    return List.generate(
        listado.length,
        (i) => ValueEntry(
            value: listado[i]['value'],
            date: 1661904000000,
            entryName: "",
            type: listado[i]['type_id'],
            categoryName: "",
            entry: listado[i]['entry_id'],
            desc: listado[i]['desc'],
            length: 1,
            latitud: 1));
  }

  static Future<int> insert(ValueEntry value) async {
    return await DatabaseSQL.insert(dbName, value);
  }
}
