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
  List<ValueEntry> listado = [];
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
//#Inicio de Region Para CRUD Entrada
  //Actualizar Registro

  Future<dynamic> updateFunction(obj, context) async {
    return {}; // await dbP.updateValueEntry(updateValueEntry);
  }
  //Eliminar Registro

  Future<dynamic> deleteFunction(id, context) async {
    //  final dbP = Provider.of<DbProvider>(context, listen: false);
    //await dbP.deleteValueEntry(id);
  }
//#Fin de Region Para CRUD Entrada

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Registros")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [const _TitleFilter(), _listRegister()]),
      ),
    );
    /* final provider = Provider.of<DbProvider>(context);
    if (provider.categoryEntries != null) {
      provider.keyFormFieldDropE!.currentState
          // ignore: invalid_use_of_protected_member
          ?.setValue(provider.categoryEntries!.id);
    }

    resetFilter() async {
      if (provider.keyFormFieldDropE!.currentState != null) {
        provider.keyFormFieldDropE!.currentState!.reset();
        provider.categoryEntries = null;
        provider.filterEntries = [];
      }
      provider.categorya = null;
      await provider.getEntry();*/
  }

/*Region Screen */
  /*  return Scaffold(
        appBar: AppBar(title: const Text("Mis Registros")),
        floatingActionButton: FloatingActionButton(
            onPressed: resetFilter,
            child: const Icon(Icons.filter_alt_off_outlined)),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: _TitleFilter(),
          ),
          provider.valueEntrysD2!.isEmpty
              ? const _NotList()
              : _listRegister(provider),
        ]));
  }*/

/*Return*/
  Expanded _listRegister() {
    final valueEntryList = ref.watch(valueEntryProvider);
    return Expanded(
      child: valueEntryList.isEmpty
          ? Container()
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomEditValueEntry(
                      delete: (index) {
                        return Future(() => null);
                      },
                      update: (index) {
                        return Future(() => null);
                      },
                      valueEntry: valueEntryList[index]),
                );
              },
              itemCount: valueEntryList.length,
            ),
    );
  }
  /*Expanded _listRegister(DbProvider provider) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          provider.valueEntrysD2![index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElementCustomEditValueEntry(
                padding: 10,
                label: "lolo",
                obj: provider.valueEntrysD2![index],
                deleteFunction: () {}, // deleteFunction,
                updateFunction: () {} //updateFunction
                ),
          );
        },
        itemCount: provider.valueEntrysD2!.isEmpty
            ? 1
            : provider.valueEntrysD2!.length,
      ),
    );
  }*/
}

class _TitleFilter extends StatelessWidget {
  const _TitleFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*var provider = Provider.of<DbProvider>(context);
    provider.getEntry();
    provider.getCategorias();
*/
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
        //  _ButtonFilter(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

/*class _NotList extends StatelessWidget {
  const _NotList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
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
*/
class _ListValueEntrys extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entradaProvider = ref.watch(entryProvider);
    return SizedBox(
        height: 100,
        child:
            entradaProvider.isEmpty ? Container() : listado(entradaProvider));
    /* entradaProvider.when(
            data: (data) => listado(data),
            error: (error, _) => const WidgetErrorAlert(),
            loading: () => Container()))*/
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




/*
class _ButtonFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            label: const Text("Filtros")),
        TextButton(
            onPressed: () async {
              await provider.getValueEntries();
              await provider.setNewList();
            },
            child: const Text("Buscar"))
      ],
    );
  }
}
*/
/*
class _DropwdownFilter extends ConsumerWidget
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final categoriaProvider = ref.watch(categoryProviderList);
   // final provider = Provider.of<DbProvider>(context, listen: false);
    return Expanded(
        child: DropdownButtonFormField(
            key: provider.keyFormFieldDropE,
            decoration: const InputDecoration(labelText: "Categorias"),
            items: provider.categorias != null
                ? provider.categorias!
                    .where((element) => element.enable!)
                    .map((Category e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name!),
                        ))
                    .toList()
                : const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text("1"),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text("2"),
                    )
                  ],
            onChanged: (value) async {
              await provider.setSubCategoriasFilter(value.toString());
            }));
  }
}*/
