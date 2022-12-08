import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier {
  List<Category>? categorias = [];

  DbProvider();

  getCategorias<Category>() {
    return categorias;
  }
}
