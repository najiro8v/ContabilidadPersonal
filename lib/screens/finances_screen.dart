// ignore_for_file: use_build_context_synchronously

import 'package:contabilidad/provider/db_provider.dart';
import 'package:flutter/material.dart';

import 'package:contabilidad/controllers/controller.dart';
import "package:contabilidad/widget/widget.dart";
import 'package:contabilidad/models/models.dart';
import 'package:provider/provider.dart';

import 'registries/registries_filter.screen.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({Key? key}) : super(key: key);

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    var entryValue = Provider.of<DbProvider>(context);
    return Scaffold(
      body: Form(
        key: myFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: ListView(children: [
            const _TitleFilter(),
            if (entryValue.entrya != null && entryValue.entrya!.id != null)
              SwitchListTile(
                  title: Text(
                      "Entrada de tipo ${entryValue.valueEntry!.type == 1 ? "Credito" : "Debito"} "),
                  value: entryValue.valueEntry!.type == 1 ? true : false,
                  onChanged: ((value) {
                    entryValue.valueEntry!.type = value == true ? 1 : 2;
                  })),
            const SizedBox(
              height: 8,
            ),
            if (entryValue.entrya != null && entryValue.entrya!.id != null)
              InputsCustom(
                initialValue: entryValue.entrya!.name!,
                labelText: "descripción",
                padding: 10,
              ),
            if (entryValue.entrya != null && entryValue.entrya!.id != null)
              InputsCustom(
                initialValue: entryValue.entrya!.value!.toString(),
                isNumber: true,
                labelText: "valor",
                padding: 10,
                keyboardType: TextInputType.number,
                onValueChanges: (value) {
                  String valor = value;
                  if (valor.isEmpty) return;
                  valor.replaceAll(" ", "");
                  if (valor.contains(",")) valor = valor.replaceAll(",", ".");
                  entryValue.valueEntry!.value = double.tryParse(valor);
                },
              ),
            if (entryValue.entrya != null && entryValue.entrya!.id != null)
              TextButton(
                  onPressed: () async {
                    myFormKey.currentState!.validate();
                    if (!myFormKey.currentState!.validate()) {
                      return;
                    }
                    if (entryValue.entrya != null) return;
                    int idEntry = await EntryController.getId(Entry(
                        category: 0,
                        key: entryValue.entrya!.key,
                        name: "",
                        value: 0));
                    final ValueEntry newEntry = ValueEntry(
                        desc: entryValue.valueEntry!.desc,
                        value: entryValue.valueEntry!.value,
                        date: DateTime.now().toUtc().millisecondsSinceEpoch,
                        latitud: 1,
                        length: 1,
                        type: entryValue.valueEntry!.type == 0 ? 1 : 2,
                        entry: idEntry);
                    ValueEntryController.insert(newEntry);
                    myFormKey.currentState!.reset();

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
                    key: categoP.keyFormFieldDrop,
                    decoration: const InputDecoration(labelText: "Categorias"),
                    items: categoP.categorias != null
                        ? categoP.categorias!
                            .where((element) => element.enable!)
                            .map((Category e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name!),
                                ))
                            .toList()
                        : const [
                            DropdownMenuItem(
                              value: "1",
                              child: Text("Sin cargas"),
                            ),
                            DropdownMenuItem(
                              value: "1",
                              child: Text("Sin cargas"),
                            )
                          ],
                    onChanged: (value) async {
                      await categoP.setSubCategorias(value.toString());
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
                  onPressed: () {
                    categoP.entrya = register;
                    categoP.setValueEntry(ValueEntry(
                        desc: register.name,
                        value: register.value,
                        date: DateTime.now().toUtc().millisecondsSinceEpoch,
                        latitud: 1,
                        length: 1,
                        type: 1,
                        entry: register.id));
                  },
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
