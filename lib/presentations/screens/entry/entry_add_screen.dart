import 'package:contabilidad/domain/entities/models/models.dart';
import 'package:contabilidad/presentations/provider/db%20provider/db_provider_categories_and_entry.dart';
import 'package:contabilidad/presentations/widget/inputs/inputs_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import "package:flutter/material.dart";

class EntryAdd extends ConsumerWidget {
  final Entry? entry;

  EntryAdd({super.key, this.entry});

  final inputControllerPrice = TextEditingController();
  final inputControllerDesc = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Mis Categoria"))),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            WidgetInputsCustom(
              controller: inputControllerDesc,
              labelText: "Descripción",
              onChanged: (value) {},
            ),
            WidgetInputsCustom(
              controller: inputControllerPrice,
              labelText: "Precio",
              keyboardType: TextInputType.number,
              validator: (value) => null,
              onChanged: (value) {},
            ),
            TextButton(
                onPressed: () async {
                  if (inputControllerDesc.text.isEmpty &&
                      inputControllerPrice.text.isEmpty) return;

                  if (entry?.id == null) {
                    var uuid = const Uuid().v4();
                    final price =
                        double.tryParse(inputControllerPrice.text) ?? 0;

                    final Entry newEntry = entry!.copyWith(
                        key: uuid,
                        name: inputControllerDesc.text,
                        value: price);
                    ref.read(entryProvider.notifier).addData(newEntry);

                    context.pop();
                  }
                },
                child: Text(entry?.id == null ? "Guardar" : "Actualizar"))
          ],
        ));
  }
}
