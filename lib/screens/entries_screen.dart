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

  Future _openDatePicker() async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Periodo de las entradas"),
            content: Form(
              key: myFormKey,
              child: Column(
                children: [
                  InputDatePickerFormField(
                      onDateSaved: (value) {
                        formDate["dateI"] = value;
                        setState(() {});
                      },
                      fieldLabelText: "Fecha incial",
                      initialDate: formDate["dateI"] ?? DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 20,
                          DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(DateTime.now().year + 20,
                          DateTime.now().month, DateTime.now().day),
                      onDateSubmitted: (value) {
                        formDate["dateI"] = value;
                        setState(() {});
                      },
                      autofocus: true),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              TextButton(
                onPressed: _return,
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange[700]),
                child: const Text("Cancelar"),
              ),
              TextButton(onPressed: submit, child: const Text("Guardar"))
            ],
          ));

  submit() async {
    myFormKey.currentState!.save();
    if (!myFormKey.currentState!.validate()) {
      return;
    }
    await getEntrys();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  _return() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    getEntrys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Registros")),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey.withOpacity(0.5),
          child: const Icon(Icons.date_range_outlined),
          onPressed: () async {
            await _openDatePicker();
          }),
      extendBody: true,
      body: ListView.builder(
        itemBuilder: (_, index) {
          if (listado.isEmpty) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Listado Sin Entradas",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ));
          }

          return ElementCustomEdit(
              emitFunction: getEntrys(),
              padding: 10,
              label: "lolo",
              obj: listado[index],
              deleteFunction: deleteFunction,
              updateFunction: updateFunction);
        },
        itemCount: listado.isEmpty ? 1 : listado.length,
      ),
    );
  }
}
