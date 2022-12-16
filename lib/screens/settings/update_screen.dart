import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:contabilidad/models/query_option.dart';
import 'package:contabilidad/widget/widget.dart';

import 'package:flutter/material.dart';
import 'package:contabilidad/provider/providers.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<Category> data = [];
  Map<String, List<dynamic>> subLists = {};
  getList() async {
    data = await CategoryController.get();

    setState(() {});
  }

  String lastKey = "";
  getSubList(String key) async {
    if (subLists.containsKey(key)) {
      return;
    }
    lastKey = key;
    int idCategory =
        await CategoryController.getId(Category(key: key, name: ""));
    final List<dynamic> listado = await EntryController.getBy(
        queryOption: QueryOption(
            columns: ["name", "key", "value", "Id_Entry", "category_id"],
            where: "category_id = ? and name <> '' ",
            whereArgs: [idCategory],
            orderBy: "name"));

    subLists.addAll({key: listado});
    setState(() {});
  }

  Future<dynamic> updateFunction(obj, id, formValues) async {
    final updateEntry = Entry(
        key: obj["key"],
        name: formValues["desc"],
        value: double.parse(formValues["value"]),
        category: obj["category_id"]);
    return await EntryController.update(updateEntry, id);
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

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
    return dbP.lastOpen;
  }

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
        body: SingleChildScrollView(
          child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                index;
                if (bd.subCategory[e.key] == null) {
                  return Container();
                }
                var entry = bd.subCategory[e.key]![index];
                return Container(
                    margin: const EdgeInsets.all(10),
                    child: ElementCustomEdit(
                      emitFunction: bd.getSubCategorias(e.key!),
                      deleteFunction: updateFunction,
                      updateFunction: updateFunction,
                      label: "",
                      obj: entry,
                      padding: 10,
                    ));
              }),
        ));
  }
}
