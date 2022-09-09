import 'package:contabilidad/controllers/category_controller.dart';
import 'package:contabilidad/controllers/controller.dart';
import 'package:contabilidad/models/expenses_and_finance.dart';
import 'package:contabilidad/models/query_option.dart';
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

  getSubList(String key) async {
    if (subLists.containsKey(key)) {
      return;
    }
    int idCategory =
        await CategoryController.getId(Category(key: key, name: ""));
    final List<dynamic> listado = await EntryController.getBy(
        queryOption: QueryOption(
            columns: ["name", "key", "value"],
            where: "category_id = ? ",
            whereArgs: [idCategory],
            orderBy: "name"));
    subLists.addAll({key: listado});
    setState(() {});
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
                              return Center(child: Text("${e.name}"));
                            },
                            body: Container(
                              height: 100,
                              child: ListView(
                                shrinkWrap: true,
                                children: subLists.isEmpty
                                    ? []
                                    : subLists[e.key.toString()] != null
                                        ? subLists[e.key.toString()]![0]
                                            .map((obj) =>
                                                Text(obj.name.toString()))
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