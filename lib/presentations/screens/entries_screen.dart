import 'package:contabilidad/presentations/provider/db%20provider/db_provider_categories_and_entry.dart';
import 'package:contabilidad/presentations/provider/provider_list_category.dart';
import 'package:contabilidad/presentations/widget/shared/categoria_dropdown.dart';
import 'package:contabilidad/presentations/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:contabilidad/domain/entities/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntriesScreen extends ConsumerStatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends ConsumerState<EntriesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Registros")),
      floatingActionButton: FloatingActionButton(
          onPressed: resetFilter,
          child: const Icon(Icons.filter_alt_off_outlined)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [const _TitleFilter(), _listRegister()]),
      ),
    );
  }

  resetFilter() async {
    ref.read(categorySelectionProvider.notifier).update((state) => null);
    ref.read(valueEntryProvider.notifier).cleanId();
  }

/*Return*/
  Expanded _listRegister() {
    final valueEntryList = ref.watch(valueEntryProvider);
    return Expanded(
      child: valueEntryList.isEmpty
          ? const _NotList()
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomEditValueEntry(
                      delete: (valueEntry) {
                        ValueEntry value = valueEntry;
                        ref
                            .read(valueEntryProvider.notifier)
                            .removeData(value.id!);
                        return Future(() => null);
                      },
                      update: (valueEntry) {
                        ref
                            .read(valueEntryProvider.notifier)
                            .editData(valueEntry);
                        return Future(() => null);
                      },
                      valueEntry: valueEntryList[index]),
                );
              },
              itemCount: valueEntryList.length,
            ),
    );
  }
}

class _TitleFilter extends StatelessWidget {
  const _TitleFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var expanded = Expanded(
        child: TextFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.search_sharp), labelText: "Busqueda"),
    ));

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: CategorySelector()),
            const SizedBox(
              width: 10,
            ),
            expanded,
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _ListValueEntrys(),
        const SizedBox(
          height: 10,
        ),
        _ButtonFilter(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _NotList extends StatelessWidget {
  const _NotList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Listado Sin Entradas",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _ListValueEntrys extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entradaProvider = ref.watch(entryProviderList);
    return SizedBox(
        height: 100,
        child: entradaProvider.when(
            data: (data) => data.isEmpty ? Container() : listado(data),
            error: (error, _) => const WidgetErrorAlert(),
            loading: () => Container()));
  }

  Widget listado(List<Entry> provider) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) {
        Entry entry = provider[index];
        return Container(
          width: 100,
          key: Key(entry.key.toString()),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: CheckFilter(
            filter: entry,
          ),
        );
      }),
      shrinkWrap: true,
      itemCount: provider.length,
    );
  }
}

class _ButtonFilter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () async {
              ref.read(valueEntryProvider.notifier).getData();
            },
            child: const Text("Buscar"))
      ],
    );
  }
}
