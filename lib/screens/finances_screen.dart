import 'package:flutter/material.dart';

import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/controllers/value_entry_controller.dart';
import 'package:contabilidad/models/finance_option.dart';
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
    "categoryID"
        "entry": "",
    "entryKey": "",
    "entryValue": "",
  };

  final Map<String, Map<String, subOption>> subDropdownOption = {
    "": {"": subOption(name: "", value: "")}
  };
  Map<String, String> dropdownOptions = {
    "": "",
  };

  void setList(value) {
    FocusScope.of(context).requestFocus(FocusNode());
    subKeyOption = subDropdownOption[value]!.entries.first.key;
    lista = subDropdownOption[value]!
        .entries
        .map((e) => DropdownMenuItem(
              value: e.key,
              child: Text(e.value.name),
            ))
        .toList();
    formValues["categoryKey"] = value;
    formValues["desc"] = "";
    formValues["value"] = "0";
    setState(() {});
  }

  listCategories() async {
    List<Category> listado = await CategoryController.get();
    for (var e in listado) {
      dropdownOptions.addAll({"${e.key}": "${e.name}"});
    }
    setState(() {});
  }

  listEntries() async {
    List<Entry> listado = await EntryController.get();
    for (var e in listado) {
      subDropdownOption.containsKey(e.categoryKey)
          ? subDropdownOption[e.categoryKey]!.addAll({
              e.key: subOption(name: "${e.name}", value: "${e.value}"),
            })
          : subDropdownOption.addAll({
              "${e.categoryKey}": {
                e.key: subOption(name: "${e.name}", value: "${e.value}"),
              }
            });
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
          child: ListView(children: [
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
                        formValues["desc"] = "";
                        formValues["value"] = "0";
                        formValues["entryKey"] = value.toString();
                      }),
            const SizedBox(
              height: 15,
            ),
            if (subKeyOption != null && subKeyOption!.isNotEmpty)
              InputsCustomFinances(
                initialValue: formValues["desc"],
                formProprety: "desc",
                formValues: formValues,
                labelText: "descripción",
                padding: 10,
              ),
            if (subKeyOption != null && subKeyOption!.isNotEmpty)
              InputsCustomFinances(
                formProprety: "value",
                formValues: formValues,
                initialValue: formValues["value"],
                isNumber: true,
                labelText: "valor",
                padding: 10,
              ),
            TextButton(
                onPressed: () async {
                  int idEntry = await EntryController.getId(Entry(
                      category: 0,
                      key: formValues["entryKey"]!,
                      name: "",
                      value: 0));
                  final ValueEntry newEntry = ValueEntry(
                      desc: formValues["desc"],
                      value: double.tryParse(formValues["value"]!) ?? 0,
                      date: 1661904000000,
                      latitud: 1,
                      length: 1,
                      type: 1,
                      entry: idEntry);
                  ValueEntryController.insert(newEntry);
                },
                child: const Text("Agregar Entrada"))
          ]),
        ),
      ),
    );
  }
}
