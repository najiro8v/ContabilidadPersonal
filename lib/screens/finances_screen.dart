// ignore_for_file: use_build_context_synchronously

import 'package:contabilidad/provider/db_provider.dart';
import 'package:flutter/material.dart';

import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/models/finance_option.dart';
import "package:contabilidad/widget/widget.dart";
import 'package:contabilidad/models/models.dart';
import 'package:provider/provider.dart';

import "./registries/registries_filter.screen.dart";

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
            const _TitleFilter(),
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("registries");
          },
          child: const Icon(Icons.format_list_bulleted_sharp)),
    );
  }
}

class _TitleFilter extends StatelessWidget {
  const _TitleFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoP = Provider.of<DbProvider>(context);
    categoP.getCategorias();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: "Categorias"),
                    items: /* [
                      DropdownMenuItem(
                        value: 0,
                        child: Icon(Icons.abc),
                      ),
                      const DropdownMenuItem(
                        value: 1,
                        child: Text("b"),
                      )
                    ]*/
                        categoP.categorias != null
                            ? categoP.categorias
                                ?.map((Category e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name!),
                                    ))
                                .toList()
                            : const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Icon(Icons.abc),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text("b"),
                                )
                              ],
                    onChanged: (value) {
                      categoP.setSubCategorias(value.toString());
                    })),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.search_sharp), labelText: "Busqueda"),
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              Entry register = categoP.registros![index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.access_time_filled),
                  label: Text(register.name!),
                ),
              );
            }),
            shrinkWrap: true,
            itemCount: categoP.registros!.length,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const RegistriesFilterScreen(),
                    ),
                  );
                },
                child: const Text("..."))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
