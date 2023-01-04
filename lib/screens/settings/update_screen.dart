import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:contabilidad/widget/widget.dart';

import 'package:flutter/material.dart';
import 'package:contabilidad/provider/providers.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bd = Provider.of<DbProvider>(context);
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
          bd.editCat = false;
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
                    _AddWidget(category: e),
                    IconButton(
                      onPressed: () {
                        bd.editCat = true;
                        Navigator.pushNamed(context, 'categoryScreen',
                            arguments: e);
                      },
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                    ),
                    IconButton(
                        onPressed: () {
                          bd.disableCategory(e);
                        },
                        icon: Icon(
                            e.enable! ? Icons.lock_open : Icons.lock_outline),
                        color: e.enable! ? Colors.green : Colors.red)
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
  Future<dynamic> updateFunction(obj, context) async {
    var id = obj["id"].toString();
    final dbP = Provider.of<DbProvider>(context, listen: false);

    Entry newEntry = Entry(
      name: dbP.controllerEntryList[id]!["name"]!.text,
      value: double.tryParse(dbP.controllerEntryList[id]!["value"]!.text),
      key: obj["key"],
      category: obj["category_id"],
      id: obj["id"],
    );
    return await dbP.updateSubCategory(newEntry);
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
              key: Key(entry["id"].toString()),
              margin: const EdgeInsets.all(10),
              child: ElementCustomEdit(
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
  final Category category;
  const _AddWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, 'subcategoryScreen',
              arguments: Entry(
                  name: "",
                  value: 0,
                  categoryName: category.name,
                  category: category.id,
                  categoryKey: category.key,
                  key: ""));
        },
        icon: Icon(
          Icons.playlist_add,
          color: Colors.purple[300],
        ));
  }
}
