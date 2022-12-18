import 'dart:ffi';

import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:contabilidad/widget/widget.dart';

import 'package:flutter/material.dart';
import 'package:contabilidad/provider/providers.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bd = Provider.of<DbProvider>(context, listen: false);
    bd.getCategorias();

    return (Scaffold(
      appBar: AppBar(title: const Text("Update Setting")),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            children: bd.categorias!.isEmpty
                ? []
                : bd.categorias!
                    .map((e) => _PanelRadio(e: e, context: context)
                        .expansionPanelRadio())
                    .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'categoryScreen');
        },
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    ));
  }
}

class _PanelRadio {
  Category e;
  BuildContext context;
  _PanelRadio({required this.e, required this.context});

  ExpansionPanelRadio expansionPanelRadio() {
    final bd = Provider.of<DbProvider>(context);
    return ExpansionPanelRadio(
        canTapOnHeader: true,
        value: e.key.toString(),
        headerBuilder: (context, isExpanded) {
          if (isExpanded) {
            bd.getSubCategorias(e.key!);
          }
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("${e.name}")),
                Row(
                  children: [
                    _AddWidget(entry: e),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'categoryScreen',
                            arguments: e);
                      },
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_forever),
                        color: Colors.red)
                  ],
                )
              ]);
        },
        body: SingleChildScrollView(child: _ListViewEntry(e: e)));
  }
}

// ignore: must_be_immutable
class _ListViewEntry extends StatelessWidget {
  final Category e;
  _ListViewEntry({required this.e});

  Map<String, List<dynamic>> subCategoryI = {};
  Future<dynamic> updateFunction(obj, id, formValues) async {
    final updateEntry = Entry(
        key: obj["key"],
        name: formValues["desc"],
        value: double.parse(formValues["value"]),
        category: obj["category_id"]);
    return await EntryController.update(updateEntry, id);
  }

  Future<dynamic> deleteFunction(id, context) async {
    final dbP = Provider.of<DbProvider>(context, listen: false);
    await dbP.deleteSubCategory(id);
  }

  @override
  Widget build(BuildContext context) {
    final bd = Provider.of<DbProvider>(context);

    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount:
            bd.subCategory[e.key] != null ? bd.subCategory[e.key]!.length : 0,
        itemBuilder: (context, index) {
          var entry = bd.subCategory[e.key]![index];
          return Container(
              key: UniqueKey(),
              margin: const EdgeInsets.all(10),
              child: ElementCustomEdit(
                emitFunction: bd.getSubCategorias(e.key!),
                deleteFunction: deleteFunction,
                updateFunction: updateFunction,
                label: "",
                obj: entry,
                padding: 10,
              ));
        });
  }
}

class _AddWidget extends StatelessWidget {
  final Category entry;
  const _AddWidget({required this.entry});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, 'subcategoryScreen',
              arguments: Entry(
                  name: "",
                  value: 0,
                  categoryName: entry.name,
                  category: entry.id,
                  categoryKey: entry.key,
                  key: ""));
        },
        icon: Icon(
          Icons.playlist_add,
          color: Colors.purple[300],
        ));
  }
}
