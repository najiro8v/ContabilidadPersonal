import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:contabilidad/models/query_option.dart';
import 'package:contabilidad/widget/widget.dart';
import 'package:flutter/material.dart';

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

  Future<dynamic> deleteFunction(id) async {
    await EntryController.delete(id);
    subLists[lastKey]!.removeWhere((item) => item["id"] == id);
    setState(() {});
    return lastKey;
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(title: const Text("Update Setting")),
        body: SingleChildScrollView(
          child: ExpansionPanelList.radio(
              children: data.isEmpty
                  ? []
                  : data
                      .map((e) => ExpansionPanelRadio(
                            canTapOnHeader: true,
                            value: e.key.toString(),
                            headerBuilder: (context, isExpanded) {
                              if (isExpanded) {
                                getSubList(e.key.toString());
                              }
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text("${e.name}")),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.edit),
                                          color: Colors.blue,
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.delete_forever),
                                            color: Colors.red)
                                      ],
                                    )
                                  ]);
                            },
                            body: SingleChildScrollView(
                              child: ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: subLists.isEmpty
                                    ? []
                                    : subLists[e.key.toString()] != null
                                        ? subLists[e.key.toString()]!
                                            .map((obj) => Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: ElementCustomEdit(
                                                  emitFunction: getSubList(
                                                      e.key.toString()),
                                                  deleteFunction:
                                                      deleteFunction,
                                                  updateFunction:
                                                      updateFunction,
                                                  label: "",
                                                  obj: obj,
                                                  padding: 10,
                                                )))
                                            .toList()
                                        : [],
                              ),
                            ),
                          ))
                      .toList()),
        )));
  }
}
/*
ListView(
                                    children: subLists.isEmpty
                                        ? []
                                        : subLists[e.key.toString()] != null
                                            ? subLists[e.key.toString()]!
                                                .map((obj) =>
                                                    Text(obj.name.toString()))
                                                .toList()
                                            : [],
                                  ),*/