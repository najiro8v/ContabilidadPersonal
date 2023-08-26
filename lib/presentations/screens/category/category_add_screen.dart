import 'package:contabilidad/domain/entities/models/models.dart';
import "package:flutter/material.dart";

import 'package:contabilidad/presentations/provider/providers.dart';

class CategoryAdd extends StatelessWidget {
  const CategoryAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
/*
    ///    final categoryProvider = Provider.of<DbProvider>(context, listen: false);
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
                autofocus: true,
                decoration:
                    const InputDecoration(labelText: "Código de Categoria"),
                initialValue: categoryEdit.key ?? "",
                enabled: categoryEdit.key != null ? false : true,
                onChanged: (value) {
                  categoryProvider.category?.key = value;
                }),
            TextFormField(
                decoration: const InputDecoration(labelText: "Descripción"),
                initialValue: categoryEdit.name ?? "",
                onChanged: (value) {
                  categoryProvider.category?.name = value;
                }),
            TextButton(
                onPressed: () async {
                  if (categoryProvider.editCat == false) {
                    bool saved = await categoryProvider
                        .saveCategory(categoryProvider.category!);
                    if (saved) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  } else {
                    bool saved = await categoryProvider
                        .updateCategory(categoryProvider.category!);
                    if (saved) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Text(
                    categoryProvider.editCat == false ? "Guardar" : "Editar"))
          ],
        ));
        */
  }
}
