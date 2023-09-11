import 'package:contabilidad/domain/entities/models/expenses_and_finance.dart';
import 'package:contabilidad/presentations/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:contabilidad/presentations/widget/widget.dart";

class FinancesScreen extends ConsumerStatefulWidget {
  const FinancesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends ConsumerState<FinancesScreen> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Entrada agregada con exito'),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  final inputControllerDesc = TextEditingController();
  final inputControllerCant = TextEditingController();
  final inputControllerPrice = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //  inputControllerDesc.dispose();
    // inputControllerCant.dispose();
    //inputControllerPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var entryValue = Provider.of<DbProvider>(context);
    //var data = ref.watch(CategoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: myFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: ListView(children: [
            _TitleFilter(),
            //if (entryValue.entrya != null && entryValue.entrya!.id != null)
            SwitchListTile(
                title: const Text(
                    "" //"Entrada de tipo ${entryValue.valueEntry!.type == 1 ? "Credito" : "Debito"} "
                    ),
                value: true, // entryValue.valueEntry!.type == 1 ? true : false,
                onChanged: ((value) {
                  // entryValue.valueEntry!.type = value == true ? 1 : 2;
                })),
            const SizedBox(
              height: 8,
            ),
            //if (entryValue.entrya != null && entryValue.entrya!.id != null)
            /*InputsCustom(
              initialValue: "", // entryValue.entrya!.name!,
              propiedad: "desc",
              labelText: "descripción",
              padding: 10,
              isNumber: false,
            ),*/

            ///if (entryValue.entrya != null && entryValue.entrya!.id != null)
            WidgetInputsCustom(
              controller: inputControllerDesc,
              labelText: "descipción",
              onChanged: (value) {
                //print(value);
              },
            ),
            WidgetInputsCustom(
              controller: inputControllerCant,
              labelText: "Cantidad",
              keyboardType: TextInputType.number,
              onChanged: (value) {
                //print(value);
              },
            ),
            WidgetInputsCustom(
              controller: inputControllerPrice,
              labelText: "Precio",
              keyboardType: TextInputType.number,
              onChanged: (value) {
                //print(value);
              },
            ),
            // if (entryValue.entrya != null && entryValue.entrya!.id != null)
            TextButton(
                onPressed: () async {
                  myFormKey.currentState!.validate();
                  if (!myFormKey.currentState!.validate()) {
                    return;
                  }
                  //if (entryValue.entrya == null) return;

                  /*final ValueEntry newEntry = ValueEntry(
                        desc: entryValue.valueEntry!.desc,
                        value: entryValue.valueEntry!.value,
                        date: DateTime.now().toUtc().millisecondsSinceEpoch,
                        latitud: 1,
                        length: 1,
                        type: entryValue.valueEntry!.type == 0 ? 1 : 2,
                        entry: entryValue.valueEntry!.entry);
                    int insert = await ValueEntryController.insert(newEntry);
  */
                  //myFormKey.currentState!.reset();

                  _showToast(context);
                  setState(() {});
                  /*if (insert > 0) {
                      entryValue.controllerCategory["desc"] =
                          TextEditingController(text: "");
                      entryValue.controllerCategory["value"] =
                          TextEditingController(text: "");
                    }*/
                },
                child: const Text("Agregar Entrada")),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("registries");
          },
          child: const Icon(Icons.format_list_bulleted_sharp)),
    );
  }
}

class _TitleFilter extends ConsumerWidget {
  final GlobalKey<FormFieldState> keyFormFieldDrop =
      GlobalKey<FormFieldState>();
  _TitleFilter({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //categoP.getCategorias();

    return const Column(
      children: [
        _CategorySelector(),
        _SubCategory(),
        SizedBox(
          height: 10,
        ),
        /*
        if (categoP.categorya != null)
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                Entry register = categoP.registros![index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton.icon(
                    onPressed: () {
                      categoP.entrya = register;
                      categoP.controllerCategory["desc"] =
                          TextEditingController(text: register.name);
                      categoP.controllerCategory["value"] =
                          TextEditingController(
                              text: register.value.toString());
                      categoP.setValueEntry(ValueEntry(
                          desc: register.name,
                          value: register.value,
                          date: DateTime.now().toUtc().millisecondsSinceEpoch,
                          latitud: 1,
                          length: 1,
                          type: 1,
                          entry: register.id));
                    },
                    icon: const Icon(Icons.access_time_filled),
                    label: Text(
                      register.name!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }),
              shrinkWrap: true,
              itemCount: categoP.registros!.length,
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const RegistriesFilterScreen(),
                    ),
                  );
                },
                child: const Text("..."))
          ],
        ),
        const SizedBox(
          height: 10,
        ),*/
      ],
    );
  }
}

class _SubCategory extends ConsumerWidget {
  const _SubCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entradaProvider = ref.watch(entryProvider);
    final screen = MediaQuery.of(context);
    return SizedBox(
      height: screen.size.height * 0.10,
      child: entradaProvider.when(
          data: (elements) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: elements.length,
                itemBuilder: (context, index) =>
                    _ButtonSubCategory(entry: elements[index]));
            /*
            final listElement = elements
                .map((Entry e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name!),
                    ))
                .toList();
            return DropdownButtonFormField(
                items: listElement,
                onChanged: (value) async {
                  // await categoP.setSubCategorias(value.toString());
                });*/
          },
          error: (error, _) => const WidgetErrorAlert(),
          loading: () => Container()),
    );
  }
}

class _CategorySelector extends ConsumerWidget {
  const _CategorySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var categoriaProvider = ref.watch(categoryProvider);

    return Center(
      child: categoriaProvider.when(
          data: (elements) {
            final listElement = elements
                .where((element) => element.enable!)
                .map((Category e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name!),
                    ))
                .toList();
            return DropdownButtonFormField(
                items: listElement,
                onChanged: (value) async {
                  int newState = value as int;
                  ref
                      .read(entryIdProvider.notifier)
                      .update((state) => newState);
                  // await categoP.setSubCategorias(value.toString());
                });
          },
          error: (error, _) => const WidgetErrorAlert(),
          loading: () => const CircularProgressIndicator()),
    );
  }
}

class _ButtonSubCategory extends StatelessWidget {
  final Entry entry;
  const _ButtonSubCategory({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton.icon(
        onPressed: () {
          /*categoP.entrya = register;
          categoP.controllerCategory["desc"] =
              TextEditingController(text: register.name);
          categoP.controllerCategory["value"] =
              TextEditingController(text: register.value.toString());
          categoP.setValueEntry(ValueEntry(
              desc: register.name,
              value: register.value,
              date: DateTime.now().toUtc().millisecondsSinceEpoch,
              latitud: 1,
              length: 1,
              type: 1,
              entry: register.id));*/
        },
        icon: const Icon(Icons.access_time_filled),
        label: Text(
          entry.name!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
