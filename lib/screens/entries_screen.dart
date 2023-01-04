import 'package:contabilidad/provider/providers.dart';
import 'package:contabilidad/widget/element_custom_edit_value.dart';
import 'package:flutter/material.dart';
import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/widget/widget.dart';
import 'package:contabilidad/models/models.dart';
import 'package:provider/provider.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  List<ValueEntry> listado = [];
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  Map<String, DateTime> formDate = {
    "dateI": DateTime.now(),
    "dateF": DateTime.now()
  };

  getEntrys({int toast = 0}) async {
    listado = await ValueEntryController.get();
    listado.sort((a, b) => a.categoryName!.compareTo(b.categoryName!));

    final dateFilter = formDate["dateI"] ?? DateTime.now();
    final m = dateFilter.month < 10
        ? "0${dateFilter.toUtc().month}"
        : dateFilter.month;
    final d = dateFilter.toUtc().day < 10
        ? "0${dateFilter.toUtc().day}"
        : dateFilter.toUtc().day;

    final today = DateTime.parse("${dateFilter.toUtc().year}-$m-$d 00:00:00Z");
    listado =
        listado.where((i) => i.date! >= today.millisecondsSinceEpoch).toList();
    setState(() {});
  }

  Future<dynamic> updateFunction(obj, context) async {
    var id = obj["id"].toString();
    final dbP = Provider.of<DbProvider>(context, listen: false);
    final updateValueEntry = ValueEntry(
      id: obj["id"],
      desc: dbP.controllerValueEntryList[id]!["desc"]!.text,
      value: double.tryParse(dbP.controllerValueEntryList[id]!["value"]!.text),
      date: obj["date"],
      entry: obj["entry_id"],
      latitud: 1,
      length: 1,
      type: obj["type_id"],
    );
    return await dbP.updateValueEntry(updateValueEntry);
  }

  Future<dynamic> deleteFunction(id, context) async {
    final dbP = Provider.of<DbProvider>(context, listen: false);
    await dbP.deleteValueEntry(id);
  }

  submit() async {
    myFormKey.currentState!.save();
    if (!myFormKey.currentState!.validate()) {
      return;
    }
    await getEntrys();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    getEntrys();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context);
    if (provider.categoryEntries != null) {
      provider.keyFormFieldDropE!.currentState
          // ignore: invalid_use_of_protected_member
          ?.setValue(provider.categoryEntries!.id);
    }
    return Scaffold(
        appBar: AppBar(title: const Text("Mis Registros")),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.filter_alt_off_outlined),
            onPressed: () async {
              if (provider.keyFormFieldDropE!.currentState != null) {
                provider.keyFormFieldDropE!.currentState!.reset();
                provider.categoryEntries = null;
                provider.filterEntries = [];
              }

              provider.categorya = null;
              await provider.getEntry();
            }),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: _TitleFilter(),
          ),
          provider.valueEntrysD2!.isEmpty
              ? const _NotList()
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      provider.valueEntrysD2![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ElementCustomEditValueEntry(
                            padding: 10,
                            label: "lolo",
                            obj: provider.valueEntrysD2![index],
                            deleteFunction: deleteFunction,
                            updateFunction: updateFunction),
                      );
                    },
                    itemCount: provider.valueEntrysD2!.isEmpty
                        ? 1
                        : provider.valueEntrysD2!.length,
                  ),
                ),
        ]));
  }
}

class _TitleFilter extends StatelessWidget {
  const _TitleFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbProvider>(context);
    provider.getEntry();
    provider.getCategorias();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: DropdownButtonFormField(
                    key: provider.keyFormFieldDropE,
                    decoration: const InputDecoration(labelText: "Categorias"),
                    items: provider.categorias != null
                        ? provider.categorias!
                            .where((element) => element.enable!)
                            .map((Category e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name!),
                                ))
                            .toList()
                        : const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text("1"),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text("2"),
                            )
                          ],
                    onChanged: (value) async {
                      await provider.setSubCategoriasFilter(value.toString());
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
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              Entry entry = provider.categoryEntries != null
                  ? provider.registrosEntries![index]
                  : provider.registrosAll![index];
              return Container(
                width: 100,
                key: Key(entry.key.toString()),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: CheckFilter(
                  filter: entry,
                ),
              );
            }),
            shrinkWrap: true,
            itemCount: provider.categoryEntries != null
                ? provider.registrosEntries!.length
                : provider.registrosAll!.length,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                label: const Text("Filtros")),
            TextButton(
                onPressed: () async {
                  // await _openDatePicker();
                  await provider.getValueEntries();
                  await provider.setNewList();
                },
                child: const Text("Buscar"))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _NotList extends StatelessWidget {
  const _NotList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text(
            "Listado Sin Entradas",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
