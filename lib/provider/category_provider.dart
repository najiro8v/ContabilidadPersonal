import 'package:flutter/material.dart';
import 'package:contabilidad/models/models.dart';
//import "../controllers/category_controller.dart";
//import "../controllers/entry_controller.dart";

class CategoryProvider extends ChangeNotifier {
  ValueEntry? valueEntry;
  Category? category;
  Entry? entry;
  CategoryProvider();

  setSubCategory(Entry obj) {
    entry = obj;
  }
}
