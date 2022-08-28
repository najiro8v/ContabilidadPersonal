import 'package:contabilidad/models/models.dart' show Entry;
import "package:contabilidad/db/db.dart";

class EntryController {
  static const String dbName = "Entry";
  static Future<List<Entry>> getCategories() async {
    List<dynamic> listado = await DatabaseSQL.get(dbName);
    return List.generate(
        listado.length,
        (i) => Entry(
            value: listado[i]['value'],
            category: listado[i]['category_id'],
            key: listado[i]['key'],
            name: listado[i]['name']));
  }

  static Future<void> insertCategorie(Entry entry) async {
    await DatabaseSQL.insert(dbName, Entry);
  }
}
