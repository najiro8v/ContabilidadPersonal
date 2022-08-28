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
    "gto": "Gastos",
    "ing": "Ingresos",
    "trans": "Transporte",
    "add": "Agregar uno nuevo",
  };
  String option = "";
  String subCategory = "";
  String category = "";
  double categoryValue = 0.0;
  double valueInitial = 0.0;
  bool addEnded = true;
  bool event = true;

  listCategory() async {
    //if (!kIsWeb) List<dynamic> listado = await DatabaseSQL.get("Category");
  }

  dropTable() async {
    //await DatabaseSQL.dropResest();
  }

  addExpenses() async {}

  @override
  void initState() {
    super.initState();
    //listExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      "category": "",
      "categoryKey": "",
      "entry": "",
      "entryKey": "",
      "entryValue": "",
    };
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
                      this.event = false;
                    } else {
                      formValues["category"] = option;
                      formValues["categoryKey"] = "";
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
                    if (option == "add") {
                      print("agregado");
                      var a = Category(
                          key: formValues["categoryKey"],
                          name: formValues["category"]);

                      print(a.name);
                      await CategoryController.insertCategorie(a);
                    }

                    print(formValues);
                  },
                  child: const Text("Agregar Categoria"))
            ],
          ),
        ),
      ),
    );
  }
}
