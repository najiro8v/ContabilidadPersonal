import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:contabilidad/models/models.dart';
import 'package:flutter/material.dart';
import "../controllers/category_controller.dart";
import "../controllers/entry_controller.dart";
import 'package:contabilidad/models/query_option.dart';

class DbProvider extends ChangeNotifier {
  List<Category>? categorias = [];
  List<Entry>? registros = [];
  String lastOpen = "";
  Map<String, List<dynamic>> subCategory = {};
  Entry? entry;
  DateTime? initialDate;
  DateTime? endDate;
  double? precio;
  double? cantidad;
  String? descr;
  DbProvider();

  getCategorias<Category>() async {
    categorias = await CategoryController.get();
    return categorias;
  }

  getEntry<Entry>() async {
    registros = await EntryController.get();
    return categorias;
  }

  getSubCategorias(String key) async {
    int idCategory =
        await CategoryController.getId(Category(key: key, name: ""));
    final List<dynamic> listado = await EntryController.getBy(
        queryOption: QueryOption(
            columns: ["name", "key", "value", "Id_Entry", "category_id"],
            where: "category_id = ? and name <> '' ",
            whereArgs: [idCategory],
            orderBy: "name"));
    if (!subCategory.containsKey(key)) {
      subCategory.addAll({key: listado});
    } else {
      subCategory[key] = listado;
    }
    lastOpen = key;
    notifyListeners();
  }

  setSubCategorias(String idCategory) async {
    registros = await EntryController.getByCategory(idCategory);
    notifyListeners();
  }

  saveSubCategory(Entry entry, String keyCategory) async {
    await EntryController.insert(entry);
    await getSubCategorias(keyCategory);
  }

  deleteEntry(int id) async {
    await EntryController.delete(id);
    subCategory[lastOpen]!.removeWhere((item) => item["id"] == id);
    await getSubCategorias(lastOpen);
  }
}
