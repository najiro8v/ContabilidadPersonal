import 'package:flutter/material.dart';

import 'package:contabilidad/db/db.dart';

import 'package:contabilidad/models/models.dart';

class AddingScreen extends StatefulWidget {
  const AddingScreen({Key? key}) : super(key: key);

  @override
  State<AddingScreen> createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  final Map<String, String> dropdownOptions = {
    "gto": "Gastos",
    "ing": "Ingresos",
    "trans": "Transporte",
    "add": "Agregar uno nuevo",
  };
  String option = "";
  String subCategory = "";
  String category = "";
  double valueInitial = 0.0;

  listExpenses() async {
    print("---");
    List<ExpensesAndFinance> listado = await DatabaseSQL.getAll();
  }

  dropTable() async {
    print("RESET");
    await DatabaseSQL.dropResest();
  }

  addExpenses() async {
    await DatabaseSQL.insert(ExpensesAndFinance(
        id: 2,
        name: "ExpensesAndFinance",
        desc: "Pruebas de sqlite",
        key: "test",
        price: 15.55));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //listExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            DropdownButtonFormField(
                hint: const Text("Selecciona una categoria"),
                items: dropdownOptions.entries
                    .map((value) => DropdownMenuItem(
                          value: value.key,
                          child: Text(value.value),
                        ))
                    .toList(),
                onChanged: ((value) {
                  option = value.toString();
                  setState(() {});
                })),
            const SizedBox(height: 15),
            if (option == "add")
              TextFormField(
                onChanged: (value) {
                  category = value.toString();
                  setState(() {});
                },
                decoration: const InputDecoration(
                    label: Text("Nombre de la categoria")),
              ),
            const SizedBox(height: 15),
            if (option.isNotEmpty)
              TextFormField(
                onChanged: (value) {
                  subCategory = value.toString();
                  setState(() {});
                },
                decoration: const InputDecoration(
                    label: Text("Nombre de la subcategoría")),
              ),
            const SizedBox(height: 15),
            if (subCategory.isNotEmpty)
              TextFormField(
                onChanged: (value) {
                  valueInitial = double.parse(value.toString());
                  setState(() {});
                },
                decoration: const InputDecoration(
                    label: Text("Valor inicial de la subcategoría")),
              ),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: addExpenses,
                    child: const Text("Agregar a la base de datos")),
                TextButton(
                    onPressed: listExpenses,
                    child: const Text("Leer  la base de datos")),
                TextButton(
                    onPressed: dropTable, child: const Text("Drop table")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
