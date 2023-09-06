import 'package:contabilidad/domain/entities/models/models.dart';

import 'package:flutter/material.dart';
import 'package:contabilidad/infrastructure/repository/controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//repositorio inmutables
final CategoryProvider = FutureProvider<List<Category>>((ref) async {
  final category = CategoryController();
  return category.readData(QueryOption());
});

class DbProvider extends ChangeNotifier {
  List<Category>? categorias = [];
  List<Entry>? registros = [];
  List<Entry>? registrosEntries = [];
  List<Entry>? registrosAll = [];
  List<String>? filterEntries = [];
  List<ValueEntry>? valueEntrys = [];
  List<dynamic>? valueEntrysD = [];
  List<dynamic>? valueEntrysD2 = [];
  String lastOpen = "";
  bool editCat = false;

  Map<String, List<dynamic>> subCategory = {};
  Entry? entry;
  Entry? entrya;
  Category? categorya;
  Category? categoryEntries;
  Category? category;
  ValueEntry? valueEntry;
  ValueEntry? valueEntryEdit;
  DateTime? initialDate;
  DateTime? endDate;
  double? precio;
  double? cantidad;
  String? descr;
  GlobalKey<FormFieldState>? keyFormFieldDrop = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState>? keyFormFieldDropE = GlobalKey<FormFieldState>();
  DbProvider();
  Map<String, TextEditingController?> controllerCategory = {
    "desc": TextEditingController(),
    "value": TextEditingController(),
  };

  Map<String, Map<String, TextEditingController?>> controllerEntryList = {};
  Map<String, Map<String, TextEditingController?>> controllerValueEntryList =
      {};
  TextEditingController? controllerDesc;
  TextEditingController? controllerValue;

  getCategorias<Category>() async {
    //  categorias = await CategoryController.get();
    notifyListeners();
  }

  addFilter(String value) async {
    filterEntries!.add(value);

    notifyListeners();
  }

  setNewList() {
    valueEntrysD2 = valueEntrysD!;
    notifyListeners();
  }

  getValueEntries() async {
    /* valueEntrysD = await ValueEntryController.getBy(
        queryOption: QueryOption(
            columns: [
          "desc",
          "value",
          "Id_Value_Entry",
          "entry_id",
          "date",
          "type_id"
        ],
            where:
                "entry_id in (${List.filled(filterEntries!.length, '?').join(',')})  ",
            whereArgs: filterEntries,
            orderBy: "desc"));*/
    notifyListeners();
  }

  removeFilter(String value) {
    filterEntries!.removeWhere((item) => item == value);
    notifyListeners();
  }

  getEntry<Entry>() async {
    //registros = await EntryController.get();
    //  registrosAll = await EntryController.get();
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
        /*/    int idCategory =
    //        await CategoryController.getId(Category(key: key, name: ""));
        final List<dynamic> listado = await EntryController.getBy(
            queryOption: QueryOption(
                columns: ["name", "key", "value", "Id_Entry", "category_id"],
                where: "category_id = ? and name <> '' ",
                whereArgs: [idCategory],
                orderBy: "name"));*/

        // subCategory.addAll({key: listado});
        notifyListeners();
      }
    }
  }

  setSubCategorias(String idCategory) async {
    //registros = await EntryController.getByCategory(idCategory);
    categorya =
        categorias!.firstWhere((cat) => cat.id.toString() == idCategory);
    notifyListeners();
  }

  setSubCategoriasFilter(String idCategory) async {
    //  registrosEntries = await EntryController.getByCategory(idCategory);
    categoryEntries =
        categorias!.firstWhere((cat) => cat.id.toString() == idCategory);
    notifyListeners();
  }

  saveSubCategory(Entry entry, String keyCategory) async {
    /* int wasInsert = await EntryController.insert(entry);
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

    return wasInsert > 0 ? true : false;*/
  }

  deleteValueEntry(int id) async {
    /*int wasDelete = await ValueEntryController.delete(id);
    if (wasDelete > 0) {
      valueEntrysD2!.removeWhere((item) => item["id"] == id);

      notifyListeners();
    }*/
  }

  deleteSubCategory(int id) async {
    /*int wasDelete = await EntryController.delete(id);
    if (wasDelete > 0) {
      subCategory[lastOpen]!.removeWhere((item) => item["id"] == id);
      if (entrya != null && entrya!.id == id) {
        entrya = null;
      }
      notifyListeners();
    }*/
  }

  saveCategory(Category category) async {
    /*  int wasInsert = await CategoryController.insert(category);
    if (wasInsert > 0) {
      Category newCategory =
          Category(name: category.name, key: category.key, enable: true);
      categorias!.add(newCategory);
      notifyListeners();
      return true;
    }

    return false;*/
  }

  updateCategory(Category category) async {
    /* int wasUpdate = await CategoryController.updateCategory(category);
    if (wasUpdate > 0) {
      Category newCategory =
          Category(name: category.name, key: category.key, enable: true);
      categorias!.add(newCategory);
      notifyListeners();
      return true;
    }

    return false;*/
  }

  updateSubCategory(Entry entry) async {
    /* int wasUpdate = await EntryController.update(entry, entry.id!);
    if (wasUpdate > 0) {
      subCategory[lastOpen]!
          .firstWhere((item) => item["id"] == entry.id)["name"] = entry.name;
      subCategory[lastOpen]!
          .firstWhere((item) => item["id"] == entry.id)["value"] = entry.value;

      notifyListeners();
      return true;
    }

    return false;*/
  }

  updateValueEntry(ValueEntry valueEntry) async {
    /* int wasUpdate =
        await ValueEntryController.update(valueEntry, valueEntry.id!);
    if (wasUpdate > 0) {
      valueEntrysD2!.firstWhere((item) => item["id"] == valueEntry.id)["desc"] =
          valueEntry.desc;
      valueEntrysD2!
              .firstWhere((item) => item["id"] == valueEntry.id)["value"] =
          valueEntry.value;

      notifyListeners();
      return true;
    }

    return false;*/
  }

  disableCategory(Category category) async {
    /* category.enable = !category.enable!;
    int wasUpdate = await CategoryController.updateCategory(category);
    if (wasUpdate > 0) {
      var entryUpdate =
          categorias!.firstWhere((element) => element.id == category.id);
      categorias!.firstWhere((element) => element.id == category.id).enable =
          category.enable;
      if (categorya != null && categorya!.id == entryUpdate.id) {
        keyFormFieldDrop!.currentState!.reset();

        categorya = null;
        entrya = null;
      }

      notifyListeners();
      return true;
    }

    return false;*/
  }
}
