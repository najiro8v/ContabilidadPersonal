import 'package:contabilidad/domain/entities/models/expenses_and_finance.dart';
import 'package:contabilidad/presentations/provider/db%20provider/db_provider_categories_and_entry.dart';
import 'package:contabilidad/presentations/widget/subcategory/custom_edit_subcategory.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UpdateScreen extends ConsumerWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriaP = ref.watch(categoryProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Update Setting")),
        body: SingleChildScrollView(
            child: categoriaP.isEmpty
                ? Container()
                : function(ref, categoriaP, context)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/Mis_categorias');
          },
          backgroundColor: Colors.indigo,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ));
  }

  Widget function(
      WidgetRef ref, List<Category> categories, BuildContext context) {
    final listado = categories.map((Category category) => _PanelRadio(
        category: category,
        context: context,
        enable: () {
          final newCategory =
              category.copyWith(enable: !(category.enable ?? false));
          ref.read(categoryProvider.notifier).stateData(newCategory);
        }).expansionPanelRadio());
    return ExpansionPanelList.radio(
      children: listado.toList(),
      expansionCallback: (panelIndex, isExpanded) {
        int newState = (categories[panelIndex].id) as int;

        if (isExpanded) {
          ref.read(entryProvider.notifier).changeCategory(newState);
        }
      },
    );
  }
}

class _PanelRadio {
  Category category;
  BuildContext context;
  Function() enable;
  _PanelRadio(
      {required this.category, required this.context, required this.enable});

  ExpansionPanelRadio expansionPanelRadio() {
    return ExpansionPanelRadio(
        canTapOnHeader: true,
        value: category,
        headerBuilder: (context, isExpanded) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("${category.name}")),
                Row(
                  children: [
                    if (!isExpanded) _AddWidget(category: category),
                    if (!isExpanded)
                      IconButton(
                        onPressed: () {
                          context.push('/Mis_categorias', extra: category);
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                      ),
                    IconButton(
                        onPressed: enable,
                        icon: Icon(category.enable!
                            ? Icons.lock_open
                            : Icons.lock_outline),
                        color: category.enable! ? Colors.green : Colors.red)
                  ],
                )
              ]);
        },
        body: SingleChildScrollView(child: _ListViewEntry(category: category)));
  }
}

class _ListViewEntry extends ConsumerWidget {
  final Category category;
  _ListViewEntry({required this.category});

  Future<dynamic> updateFunction(entry) {
    //ref.read
    return Future(() => true);
  }

  Future<dynamic> deleteFunction(id, context) async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entryP = ref.watch(entryProvider);

    return entryP.isEmpty
        ? Container()
        : ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: entryP.length,
            itemBuilder: (context, index) {
              Entry entry = entryP[index];
              return Container(
                  key: Key(entry.id.toString()),
                  margin: const EdgeInsets.all(10),
                  child: CustomEditSubCategory(
                    delete: (entry) {
                      ref.read(entryProvider.notifier).removeData(entry.id!);
                      return Future(() => true);
                    },
                    update: (entry) {
                      ref.read(entryProvider.notifier).editData(entry);
                      return Future(() => true);
                    },
                    entry: entry,
                  ));
            });
  }
}

class _AddWidget extends StatelessWidget {
  final Category category;
  const _AddWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          final addEntry = Entry(
              name: "",
              value: 0,
              id: null,
              categoryName: category.name,
              category: category.id,
              categoryKey: category.key,
              key: "");
          context.push("/sub_categorias", extra: addEntry);
        },
        icon: Icon(
          Icons.playlist_add,
          color: Colors.purple[300],
        ));
  }
}
