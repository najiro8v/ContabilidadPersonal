import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:contabilidad/models/models.dart';
import 'package:flutter/material.dart';
import "../controllers/category_controller.dart";
import "../controllers/entry_controller.dart";
import 'package:contabilidad/models/query_option.dart';

class DbProvider extends ChangeNotifier {
  List<Category>? categorias = [];
  List<Entry>? registros = [];
  List<ValueEntry>? valueEntrys = [];
  String lastOpen = "";
  Map<String, List<dynamic>> subCategory = {};
  Entry? entry;
  Entry? entrya;
  Category? categorya;
  Category? category;
  ValueEntry? valueEntry;
  DateTime? initialDate;
  DateTime? endDate;
  double? precio;
  double? cantidad;
  String? descr;
  GlobalKey<FormFieldState>? keyFormFieldDrop = GlobalKey<FormFieldState>();
  DbProvider();
  TextEditingController? controllerDesc;
  TextEditingController? controllerValue;

  getCategorias<Category>() async {
    categorias = await CategoryController.get();
    notifyListeners();
  }

  getEntry<Entry>() async {
    registros = await EntryController.get();
    notifyListeners();
  }

  setValueEntry(ValueEntry valueE) {
    valueEntry = valueE;
    notifyListeners();
  }

  getSubCategorias(String key, {bool forceUpdate = false}) async {
    if (lastOpen != key) {
      lastOpen = key;
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
      }
      notifyListeners();
    }
  }

  setSubCategorias(String idCategory) async {
    registros = await EntryController.getByCategory(idCategory);
    categorya =
        categorias!.firstWhere((cat) => cat.id.toString() == idCategory);
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

      notifyListeners();
    }

    return wasInsert > 0 ? true : false;
  }

  deleteSubCategory(int id) async {
    int wasDelete = await EntryController.delete(id);
    if (wasDelete > 0) {
      subCategory[lastOpen]!.removeWhere((item) => item["id"] == id);

      notifyListeners();
    }
  }

  saveCategory(Category category) async {
    int wasInsert = await CategoryController.insert(category);
    if (wasInsert > 0) {
      Category newCategory =
          Category(name: category.name, key: category.key, enable: true);
      categorias!.add(newCategory);
      notifyListeners();
      return true;
    }

    return false;
  }

  disableCategory(Category category) async {
    category.enable = !category.enable!;
    int wasUpdate = await CategoryController.updateCategory(category);
    if (wasUpdate > 0) {
      var entryUpdate =
          categorias!.firstWhere((element) => element.id == category.id);
      categorias!.firstWhere((element) => element.id == category.id).enable =
          category.enable;
      if (categorya != null && categorya!.id == entryUpdate.id) {
        keyFormFieldDrop!.currentState!.reset();
        registros = [];
      }

      notifyListeners();
      return true;
    }

    return false;
  }
}
