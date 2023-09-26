import 'package:contabilidad/presentations/provider/db%20provider/db_provider_categories_and_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:contabilidad/domain/entities/models/models.dart';

class CategorySelector extends ConsumerWidget {
  const CategorySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriaP = ref.watch(categoryProvider);
    final categories = categoriaP.where((element) => element.enable!).toList();
    return categories.isEmpty
        ? Container()
        : function(ref, categories, context);
  }

  Widget function(
      WidgetRef ref, List<Category> elements, BuildContext context) {
    final listElement = elements
        .map((Category e) => DropdownMenuItem(
              value: e.id,
              child: Text(e.name!),
            ))
        .toList();
    int selectedCategory = ref.read(categorySelectionProvider);
    final categoryBackUp = elements.first.id;
    dynamic value = selectedCategory;
    try {
      elements.firstWhere((Category element) => element.id == selectedCategory);
    } catch (ex) {
      value = categoryBackUp;
    }

    return DropdownButtonFormField(
        items: listElement,
        value: value,
        onChanged: (value) async {
          int newState = value as int;
          ref
              .read(categorySelectionProvider.notifier)
              .update((state) => newState);
        });
  }
}
