import 'package:contabilidad/domain/entities/models/models.dart';
import 'package:contabilidad/presentations/provider/db%20provider/db_provider_categories_and_entry.dart';
import 'package:contabilidad/presentations/provider/provider_list_category.dart';
import 'package:contabilidad/presentations/widget/shared/categoria_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:contabilidad/presentations/widget/widget.dart";
import 'package:go_router/go_router.dart';

class FinancesScreen extends ConsumerStatefulWidget {
  const FinancesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends ConsumerState<FinancesScreen> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  bool check = false;
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
    ref.read(categoryProvider.notifier).getData();
  }

  @override
  void dispose() {
    inputControllerPrice.dispose();
    inputControllerCant.dispose();
    inputControllerDesc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(categoryProvider);
    bool emptyList = list.where((element) => element.enable!).isEmpty;
    if (emptyList) {
      return const _AddCategory();
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: myFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: ListView(children: [
              _TitleFilter(
                controllers: [
                  inputControllerDesc,
                  inputControllerCant,
                  inputControllerPrice
                ],
              ),
              SwitchListTile(
                  title: Text(
                      " Tipo de registro: ${check ? "Ingresos" : "Gastos"}"),
                  value: check,
                  onChanged: ((value) {
                    ref
                        .read(checktypeProvider.notifier)
                        .update((state) => value);
                    setState(() => check = value);
                  })),
              const SizedBox(
                height: 8,
              ),
              WidgetInputsCustom(
                controller: inputControllerDesc,
                labelText: "Descripción",
                onChanged: (value) {},
              ),
              WidgetInputsCustom(
                controller: inputControllerCant,
                labelText: "Cantidad",
                keyboardType: TextInputType.number,
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
                    myFormKey.currentState!.validate();
                    if (!myFormKey.currentState!.validate()) {
                      return;
                    }
                    inputControllerCant.text;
                    inputControllerDesc.text;
                    inputControllerPrice.text;
                    final check = ref.read(checktypeProvider);
                    final value =
                        (double.tryParse(inputControllerPrice.text) ?? 0);
                    final quantity =
                        (double.tryParse(inputControllerCant.text) ?? 0);
                    final entry = ref.read(entrySelectionProvider.notifier);

                    final date = DateTime.now().millisecondsSinceEpoch;
                    final newValueEntry = ValueEntry(
                      quantity: quantity,
                      desc: inputControllerDesc.text,
                      value: value,
                      date: date,
                      entry: entry.state,
                      type: check ? 0 : 1,
                      latitud: 0,
                      length: 0,
                    );

                    ref.read(entryValueProviderState(newValueEntry));
                    _showToast(context);
                    inputControllerCant.clear();
                    inputControllerDesc.clear();
                    inputControllerPrice.text = "";

                    setState(() {});
                  },
                  child: const Text("Agregar Entrada")),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push("/Mis_Registros");
            },
            child: const Icon(Icons.format_list_bulleted_sharp)),
      );
    }
  }
}

class _AddCategory extends StatelessWidget {
  const _AddCategory();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No se encuentran categorias disponibles, por favor revisar el listado de categorias",
          textAlign: TextAlign.center,
          style: textTheme.labelLarge,
        ),
        IconButton(
          onPressed: () => {context.push("/Categorias")},
          icon: const Icon(
            Icons.arrow_circle_right_outlined,
            size: 50,
          ),
          color: Colors.indigo,
        )
      ],
    );
  }
}

class _TitleFilter extends StatelessWidget {
  final GlobalKey<FormFieldState> keyFormFieldDrop =
      GlobalKey<FormFieldState>();
  final List<TextEditingController> controllers;
  _TitleFilter({Key? key, required this.controllers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategorySelector(),
        _SubCategory(controllers: controllers),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _SubCategory extends ConsumerWidget {
  final List<TextEditingController> controllers;
  const _SubCategory({required this.controllers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entradaProvider = ref.watch(entryProviderList);

    final screen = MediaQuery.of(context);
    return SizedBox(
      height: screen.size.height * 0.10,
      child: entradaProvider.when(
          data: (elements) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: elements.length,
                itemBuilder: (context, index) => _ButtonSubCategory(
                    entry: elements[index],
                    onPressed: () {
                      final entry = elements[index];
                      ref
                          .read(entrySelectionProvider.notifier)
                          .update((state) => entry.id);
                      controllers[0].text = entry.name ?? "";
                      controllers[1].text = "1";
                      controllers[2].text = entry.value.toString();
                    }));
          },
          error: (error, _) => const WidgetErrorAlert(),
          loading: () => Container()),
    );
  }
}

class _ButtonSubCategory extends StatelessWidget {
  final Entry entry;
  final Function()? onPressed;
  const _ButtonSubCategory({required this.entry, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.access_time_filled),
        label: Text(
          entry.name!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
