import 'package:flutter/material.dart';
import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/widget/widget.dart';
import 'package:contabilidad/models/models.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  List<ValueEntry> listado = [];

  getEntrys({int toast = 0}) async {
    listado = await ValueEntryController.get();
    listado.sort((a, b) => a.categoryName!.compareTo(b.categoryName!));
    final m = DateTime.now().toUtc().month < 10
        ? "0${DateTime.now().toUtc().month}"
        : DateTime.now().month;
    final d = DateTime.now().toUtc().day < 10
        ? "0${DateTime.now().toUtc().day}"
        : DateTime.now().toUtc().day;

    final today =
        DateTime.parse("${DateTime.now().toUtc().year}-$m-$d 00:01:00Z");
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

  @override
  void initState() {
    super.initState();
    getEntrys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) => listado.isEmpty
            ? const Center(
                child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Listado Sin Entradas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ))
            : ElementCustomEdit(
                emitFunction: getEntrys(),
                padding: 10,
                label: "lolo",
                obj: listado[index],
                deleteFunction: deleteFunction,
                updateFunction: updateFunction),
        itemCount: listado.isEmpty ? 1 : listado.length,
      ),
    );
  }
}
