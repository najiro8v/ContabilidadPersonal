import 'package:contabilidad/widget/category_custom_adding.dart';
import 'package:flutter/material.dart';

///import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:contabilidad/models/models.dart';
import "package:contabilidad/controllers/controller.dart";

class AddingScreen extends StatefulWidget {
  const AddingScreen({Key? key}) : super(key: key);

  @override
  State<AddingScreen> createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  final Map<dynamic, String> dropdownOptions = {
    "": "",
    "add": "Agregar uno nuevo",
  };
  String option = "";
  String subCategory = "";
  String category = "";
  double categoryValue = 0.0;
  double valueInitial = 0.0;
  bool addEnded = true;
  bool event = true;

  listCategories() async {
    List<Category> listado = await CategoryController.get();
    for (var e in listado) {
      dropdownOptions.addAll({"${e.key}": "${e.name}"});
    }
    setState(() {});
  }

  dropTable() async {
    //await DatabaseSQL.dropResest();
  }

  addExpenses() async {}
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final Map<String, String> formValues = {
    "category": "",
    "categoryKey": "",
    "entry": "",
    "entryKey": "",
    "entryValue": "",
  };
  @override
  void initState() {
    super.initState();
    listCategories();
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Categoria agregada con exito'),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          key: myFormKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                  value: option,
                  hint: const Text("Selecciona una categoria"),
                  items: dropdownOptions.entries
                      .map((value) => DropdownMenuItem(
                            value: value.key,
                            child: Text(value.value),
                          ))
                      .toList(),
                  onChanged: ((value) {
                    option = value.toString();
                    if (option == "add") {
                      event = false;
                    } else {
                      formValues["category"] = dropdownOptions[option]!;
                      formValues["categoryKey"] = option;
                    }
                    setState(() {});
                  })),
              if (option == "add")
                CategoryCustomAdding(
                  formProprety: const {
                    "name": "category",
                    "key": "categoryKey"
                  },
                  formValues: formValues,
                  padding: 20,
                ),
              if (option.isNotEmpty)
                CategoryCustomAdding(
                  formProprety: const {
                    "name": "entry",
                    "key": "entryKey",
                    "value": "entryValue"
                  },
                  formValues: formValues,
                  padding: 0,
                ),
              const SizedBox(height: 15),
              TextButton(
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!myFormKey.currentState!.validate()) {
                      return;
                    }
                    int idCategory;

                    if (option == "add") {
                      var newCategory = Category(
                          key: formValues["categoryKey"],
                          name: formValues["category"]);
                      idCategory = await CategoryController.insert(newCategory);
                      await EntryController.insert(Entry(
                          key: newCategory.key.toString().characters.first,
                          name: "",
                          value: 0,
                          category: idCategory));
                    } else {
                      var category = Category(
                          key: formValues["categoryKey"],
                          name: formValues["category"]);
                      idCategory = await CategoryController.getId(category);
                    }
                    await EntryController.insert(Entry(
                        key: formValues["entryKey"]!,
                        name: formValues["entry"],
                        value: double.parse(formValues["entryValue"]!),
                        category: idCategory));
                    myFormKey.currentState!.reset();
                    option = "";
                    // ignore: use_build_context_synchronously
                    _showToast(context);
                    setState(() {});
                  },
                  child: const Text("Agregar Categoria"))
            ],
          ),
        ),
      ),
    );
  }
}
