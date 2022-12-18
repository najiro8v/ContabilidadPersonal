import 'package:contabilidad/models/models.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:contabilidad/provider/providers.dart';

class CategoryAdd extends StatelessWidget {
  const CategoryAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<DbProvider>(context);
    Category categoryEdit = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Category
        : Category(name: "", key: null);
    categoryProvider.category = categoryEdit;

    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Mis Categoria"))),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            TextFormField(
                decoration:
                    const InputDecoration(labelText: "Código de Categoria"),
                initialValue: categoryEdit.name ?? "",
                onChanged: (value) {
                  categoryProvider.category?.key = value;
                }),
            TextFormField(
                decoration: const InputDecoration(labelText: "Descripción"),
                initialValue: categoryEdit.key ?? "",
                onChanged: (value) {
                  categoryProvider.category?.name = value;
                }),
            TextButton(
                onPressed: () async {
                  bool saved = await categoryProvider
                      .saveCategory(categoryProvider.category!);
                  if (saved) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: Text(categoryEdit.key == null ? "Guardar" : "Editar"))
          ],
        ));
  }
}
