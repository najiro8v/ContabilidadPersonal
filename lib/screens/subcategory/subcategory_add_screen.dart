import 'package:contabilidad/models/models.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:contabilidad/provider/providers.dart';

class SubCategoryAdd extends StatelessWidget {
  const SubCategoryAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(
      context,
    );
    Entry categoryEdit = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Entry
        : Entry(name: "", value: 0, key: "", category: 0);
    categoryProvider.setSubCategory(categoryEdit);
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Mis Categoria"))),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Category"),
              initialValue: categoryEdit.categoryName ?? "",
              enabled: false,
            ),
            TextFormField(
                decoration: const InputDecoration(labelText: "Nombre"),
                initialValue: categoryEdit.name ?? "",
                onChanged: (value) {
                  categoryProvider.entry?.name = value;
                  categoryProvider.entry?.key = value;
                }),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Valor"),
                initialValue: categoryEdit.value.toString(),
                onChanged: (value) {
                  categoryProvider.entry?.value = double.tryParse(value) ?? 0;
                }),
            TextButton(
                onPressed: () async {
                  var categoP = Provider.of<DbProvider>(context, listen: false);

                  await categoP.saveSubCategory(
                      categoryProvider.entry!, categoryEdit.categoryKey!);
                },
                child: Text(categoryEdit.key == "" ? "Guardar" : "Editar"))
          ],
        ));
  }
}
