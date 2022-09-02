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
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final Map<String, String> formValues = {};
  List<ValueEntry> listado = [];
  getEntrys() async {
    listado = await ValueEntryController.get();

    for (int i = 0; i < listado.length; i++) {
      formValues.addAll({"desc$i": "$i"});
      formValues.addAll({"key$i": "$i"});
      formValues.addAll({"value$i": "$i"});
    }
    setState(() {});
  }

  @override
  void initState() {
    getEntrys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: myFormKey,
        child: ListView.separated(
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, index) => listado.isEmpty
              ? const Text("Sin Entradas")
              : ElementCustomEdit(
                  changeList: getEntrys(),
                  formProprety: {
                    "value$index": "${listado[index].value}",
                    "desc$index": "${listado[index].desc}",
                    "key$index": "${listado[index].entryName}",
                  },
                  formValues: formValues,
                  padding: 10,
                  label: "lolo",
                  index: index,
                  id: listado[index].id!),
          itemCount: listado.isEmpty ? 0 : listado.length,
        ),
      ),
    );
  }
}
