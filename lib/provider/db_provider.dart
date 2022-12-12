import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:flutter/material.dart';
import "../controllers/category_controller.dart";
import "../controllers/entry_controller.dart";

class DbProvider extends ChangeNotifier {
  List<Category>? categorias = [];
  List<Entry>? registros = [];
  DbProvider();

  getCategorias<Category>() async {
    categorias = await CategoryController.get();
    return categorias;
  }

  setSubCategorias(String idCategory) async {
    registros = await EntryController.getByCategory(idCategory);
    notifyListeners();
  }
}
