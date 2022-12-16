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

  getSubCategorias(String key, {bool forceUpdate = false}) async {
    if (!subCategory.containsKey(key) || forceUpdate) {
      int idCategory =
          await CategoryController.getId(Category(key: key, name: ""));
      final List<dynamic> listado = await EntryController.getBy(
          queryOption: QueryOption(
              columns: ["name", "key", "value", "Id_Entry", "category_id"],
              where: "category_id = ? and name <> '' ",
              whereArgs: [idCategory],
              orderBy: "name"));

      subCategory.addAll({key: listado});
      notifyListeners();
    }
    if (lastOpen != key) {
      lastOpen = key;
    }
  }

  setSubCategorias(String idCategory) async {
    registros = await EntryController.getByCategory(idCategory);
    notifyListeners();
  }

  saveSubCategory(Entry entry, String keyCategory) async {
    int wasInsert = await EntryController.insert(entry);
    if (wasInsert > 0) {
      final newEntry = Entry(
          key: entry.key,
          value: entry.value,
          category: entry.category,
          name: entry.name,
          id: wasInsert);
      subCategory[keyCategory]?.add(newEntry.toMapAll());
    }

    notifyListeners();
    return wasInsert > 0 ? true : false;
  }

  deleteSubCategory(int id) async {
    int wasDelete = await EntryController.delete(id);
    if (wasDelete > 0) {
      subCategory[lastOpen]!.removeWhere((item) => item["id"] == id);
      await getSubCategorias(lastOpen, forceUpdate: true);
    }
  }

  deleteEntry(int id) async {
    await EntryController.delete(id);
    subCategory[lastOpen]!.removeWhere((item) => item["id"] == id);
    notifyListeners();
  }
}
