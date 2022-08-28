import 'package:contabilidad/controllers/category_controller.dart';
import 'package:contabilidad/controllers/controller.dart';
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
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final Map<String, String> formValues = {
    "category": "",
    "categoryKey": "",
    "entry": "",
    "entryKey": "",
    "entryValue": "",
  };
  final Map<String, Map<String, String>> subDropdownOption = {};
  Map<String, String> dropdownOptions = {};

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

  listCategories() async {
    List<Category> listado = await CategoryController.getCategories();
    for (var e in listado) {
      dropdownOptions.addAll({"${e.key}": "${e.name}"});
    }
    setState(() {});
  }

  listEntries() async {
    List<Entry> listado = await EntryController.getCategories();
    for (var e in listado) {
      /*subDropdownOption.addAll({
        "${e.category}": {"":"",}
      );*/
    }
  }

  @override
  void initState() {
    super.initState();
    listCategories();
    listEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: myFormKey,
        child: Padding(
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
            InputsCustomFinances(
              formProprety: "desc",
              formValues: formValues,
              labelText: "descripción",
              padding: 10,
            ),
            InputsCustomFinances(
              formProprety: "value",
              formValues: formValues,
              initialValue: "0",
              isNumber: true,
              labelText: "valor",
              padding: 10,
            ),
            TextButton(
                onPressed: () {
                  DatabaseSQL.deleteDatabase('finance.db');
                },
                child: Text("delete db"))
          ]),
        ),
      ),
    );
  }
}
