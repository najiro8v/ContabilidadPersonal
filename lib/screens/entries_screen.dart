import 'package:contabilidad/provider/providers.dart';
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

  Future<dynamic> updateFunction(obj, id, formValues) async {
    final updateValueEntry = ValueEntry(
      desc: formValues["desc"],
      value: double.parse(formValues["value"]),
      date: obj.date,
      entry: obj.entry,
      latitud: obj.latitud,
      length: obj.length,
      type: obj.type,
    );
    return await ValueEntryController.update(updateValueEntry, id);
  }

  Future<dynamic> deleteFunction(id) async {
    return await ValueEntryController.delete(id);
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
    final dateI = Provider.of<DbProvider>(
      context,
    ).initialDate;
    formDate["dateI"] = dateI ?? DateTime.now();
    setState(() {});
    return Scaffold(
        appBar: AppBar(title: const Text("Mis Registros")),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: _TitleFilter(),
          ),
          listado.isEmpty
              ? const _NotList()
              : Expanded(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return ElementCustomEdit(
                                padding: 10,
                                label: "lolo",
                                obj: listado[index],
                                deleteFunction: deleteFunction,
                                updateFunction: updateFunction);
                          },
                          itemCount: listado.isEmpty ? 1 : listado.length,
                        ),
                      ]),
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: "Categorias"),
                    value: 0,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Icon(Icons.abc),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("b"),
                      )
                    ],
                    onChanged: (value) {})),
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
              return IconButton(
                  onPressed: () {}, icon: const Icon(Icons.access_time_filled));
            }),
            shrinkWrap: true,
            itemCount: 25,
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
