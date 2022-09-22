// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:contabilidad/controllers/controller.dart';
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
  String type = "";
  List<DropdownMenuItem<String>> lista = [];
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> formValues = {
    "category": "",
    "categoryKey": "",
    "entryKey": "",
    "desc": "",
    "value": "",
    "D&C": false,
  };

  final Map<String, Map<String, SubOption>> subDropdownOption = {
    "": {"": SubOption(name: "", value: "")}
  };
  Map<String, String> dropdownOptions = {
    "": "",
  };

  void setList(value) {
    FocusScope.of(context).requestFocus(FocusNode());
    type = value.toString().contains("ing") ? "Debito" : "Credito";
    dynamic subKey = subDropdownOption[value]!.entries.firstWhere(
        (element) => element.value.name.isEmpty,
        orElse: () => subDropdownOption[value]!.entries.first);
    subKeyOption = subKey.key;
    lista = subDropdownOption[value]!
        .entries
        .map((e) => DropdownMenuItem(
              value: e.key,
              child: Text(e.value.name),
            ))
        .toList();
    formValues["categoryKey"] = value;
    formValues["desc"] = subDropdownOption[value]![subKey.key]!.name;
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
              e.key: SubOption(name: "${e.name}", value: "${e.value}"),
            })
          : subDropdownOption.addAll({
              "${e.categoryKey}": {
                e.key: SubOption(name: "${e.name}", value: "${e.value}"),
              }
            });
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Entrada agregada con exito'),
        backgroundColor: Colors.green[600],
      ),
    );
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
                        final subOption = subDropdownOption[
                            formValues["categoryKey"]]![value];
                        formValues["desc"] = subOption!.name;
                        formValues["value"] = subOption.value;
                        formValues["entryKey"] = value.toString();
                        setState(() {});
                      }),
            const SizedBox(
              height: 15,
            ),
            if (subKeyOption != null && subKeyOption!.isNotEmpty)
              SwitchListTile(
                  title: Text("Entrada de tipo $type"),
                  value: formValues["D&C"],
                  onChanged: ((value) {
                    type = type.compareTo("Debito") == 0 ? "Credito" : "Debito";
                    formValues["D&C"] = !formValues["D&C"];
                    setState(() {});
                  })),
            const SizedBox(
              height: 8,
            ),
            if (subKeyOption != null && subKeyOption!.isNotEmpty)
              InputsCustomFinances(
                initialValue: formValues["desc"]!,
                formProprety: "desc",
                formValues: formValues,
                labelText: "descripción",
                padding: 10,
              ),
            if (subKeyOption != null && subKeyOption!.isNotEmpty)
              InputsCustomFinances(
                formProprety: "value",
                formValues: formValues,
                initialValue: formValues["value"]!,
                isNumber: true,
                labelText: "valor",
                padding: 10,
                keyboardType: TextInputType.number,
                onValueChanges: (value) {
                  String valor = value.toString();
                  if (valor.isEmpty) return;
                  valor.replaceAll(" ", "");
                  if (valor.contains(",")) valor = valor.replaceAll(",", ".");
                  formValues["value"] = valor.isEmpty
                      ? 0.toString()
                      : double.parse(valor).toString();
                },
              ),
            TextButton(
                onPressed: () async {
                  myFormKey.currentState!.validate();
                  if (!myFormKey.currentState!.validate()) {
                    return;
                  }
                  if (formValues["entryKey"]!.isEmpty) return;
                  int idEntry = await EntryController.getId(Entry(
                      category: 0,
                      key: formValues["entryKey"]!,
                      name: "",
                      value: 0));
                  final ValueEntry newEntry = ValueEntry(
                      desc: formValues["desc"],
                      value: double.tryParse(formValues["value"]!) ?? 0,
                      date: DateTime.now().toUtc().millisecondsSinceEpoch,
                      latitud: 1,
                      length: 1,
                      type: type.compareTo("Debito") == 0 ? 1 : 2,
                      entry: idEntry);
                  ValueEntryController.insert(newEntry);
                  myFormKey.currentState!.reset();

                  subKeyOption = "";
                  lista = [];
                  keyOption = "";
                  _showToast(context);
                  setState(() {});
                },
                child: const Text("Agregar Entrada")),
          ]),
        ),
      ),
    );
  }
}
