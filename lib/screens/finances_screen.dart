import 'package:contabilidad/controllers/category_controller.dart';
import 'package:flutter/material.dart';

import 'package:contabilidad/db/db.dart';

import "package:contabilidad/widget/widget.dart";
import 'package:contabilidad/models/models.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({Key? key}) : super(key: key);

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  String? keyOption;
  String? subKeyOption;
  List<DropdownMenuItem<String>> lista = [];
  final Map<String, Map<String, String>> subDropdownOption = {
    "gto": {
      "g": "",
      "g1": "Pago de servicio",
      "g2": "Pago de deudas",
      "g3": "Pago de comida",
      "g4": "Gastos de salidas"
    },
    "ing": {"i": "", "i1": "Pago de Trabajo", "i2": "cobro de prestamos"},
    "trans": {
      "t": "",
      "t1": "transporte de Lomas",
      "t2": "transporte de Lumaca Cartago"
    },
  };
  Map<String, String> dropdownOptions = {
    "gto": "Gastos",
    "ing": "Ingresos",
    "trans": "Transporte",
  };

  void setList(value) {
    FocusScope.of(context).requestFocus(FocusNode());
    subKeyOption = subDropdownOption[value]!.entries.first.key;
    lista = subDropdownOption[value]!
        .entries
        .map((e) => DropdownMenuItem(
              value: e.key,
              child: Text(e.value),
            ))
        .toList();
    setState(() {});
  }

  listExpenses() async {
    List<Category> listado = await CategoryController.getCategories();
    /*for (var e in listado) {
      dropdownOptions.addAll({e.key: e.name!});
    }
    setState(() {});*/
    print(listado);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: Column(children: [
          DropdownButtonFormField(
              value: keyOption,
              items: [
                ...dropdownOptions.entries
                    .map((value) => DropdownMenuItem(
                          value: value.key,
                          child: Text(value.value),
                        ))
                    .toList()
              ],
              onChanged: setList),
          DropdownButtonFormField(
              value: subKeyOption ?? "",
              items: lista,
              onChanged: lista.isEmpty
                  ? null
                  : (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
