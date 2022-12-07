//import "package:provider/provider.dart";
import 'package:flutter/material.dart';

class CategoryFilterProvider extends ChangeNotifier {
  DateTime initialDate;
  DateTime? endDate;
  double? precio;
  double? cantidad;
  String? descr;
  CategoryFilterProvider(
      {required this.initialDate,
      this.endDate,
      this.precio,
      this.cantidad,
      this.descr});

  setInitialDate(DateTime iDate) {
    initialDate = iDate;
    notifyListeners();
  }

  getInitialDate<DateTime>() {
    return initialDate;
  }

  setEndDate(DateTime iDate) {
    endDate = iDate;
    notifyListeners();
  }

  getEndDate<DateTime>() {
    return endDate;
  }

  setPrecio(double p) {
    precio = p;
    notifyListeners();
  }

  getPrecio<double>() {
    return precio;
  }

  setCantidad(double cant) {
    cantidad = cant;
    notifyListeners();
  }

  getCantidad<double>() {
    return cantidad;
  }

  setDescr(String desc) {
    descr = desc;
    notifyListeners();
  }

  getDescr<String>() {
    return descr;
  }
}
