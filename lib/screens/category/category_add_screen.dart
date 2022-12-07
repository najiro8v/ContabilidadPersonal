import 'package:contabilidad/models/models.dart';
import "package:flutter/material.dart";

class CategoryAdd extends StatelessWidget {
  const CategoryAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Category categoryEdit = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Category
        : Category(name: "", key: null);

    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Mis Categoria"))),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Categoria"),
              initialValue: categoryEdit.name ?? "",
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Descripción"),
              initialValue: categoryEdit.key ?? "",
            ),
            TextButton(
                onPressed: () {},
                child: Text(categoryEdit.key == null ? "Guardar" : "Editar"))
          ],
        ));
  }
}
