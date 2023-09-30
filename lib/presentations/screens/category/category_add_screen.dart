import 'package:contabilidad/domain/entities/models/models.dart';
import 'package:contabilidad/presentations/provider/db%20provider/db_provider_categories_and_entry.dart';
import 'package:contabilidad/presentations/widget/inputs/inputs_widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:uuid/uuid.dart';

class CategoryAdd extends ConsumerWidget {
  final Category? category;
  CategoryAdd({super.key, this.category});

  final inputControllerDesc = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Mi Categoria"))),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            WidgetInputsCustom(
                controller: inputControllerDesc,
                labelText: "Nombre de la categoria",
                onChanged: (value) {}),
            TextButton(
                onPressed: () async {
                  if (inputControllerDesc.text.isEmpty) return;
                  if (category == null) {
                    var uuid = const Uuid().v4();
                    final newCategory = Category(
                        key: uuid,
                        name: inputControllerDesc.text,
                        enable: true);
                    ref.read(categoryProvider.notifier).addData(newCategory);
                  } else {
                    final newCategory =
                        category!.copyWith(name: inputControllerDesc.text);
                    ref.read(categoryProvider.notifier).editData(newCategory);
                  }

                  context.pop();
                },
                child: Text(category == null ? "Guardar" : "Actualizar"))
          ],
        ));
  }
}
