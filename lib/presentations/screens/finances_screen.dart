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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: myFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: ListView(children: [
            _TitleFilter(),
            SwitchListTile(
                title: const Text(""),
                value: check,
                onChanged: ((value) {
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

                  int idCategory = ref.read(entryIdProvider);
                  inputControllerCant.text;
                  inputControllerDesc.text;
                  inputControllerPrice.text;
                  final category = Category(
                      key: inputControllerCant.text,
                      name: inputControllerDesc.text);
                  ref.read(categoryProvider.notifier).addData(category);

                  _showToast(context);
                  setState(() {});
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
    return const Column(
      children: [
        _CategorySelector(),
        _SubCategory(),
        SizedBox(
          height: 10,
        ),
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
    return Center(child: Listado(categoriaProvider, ref));
  }

  Widget Listado(List<Category> categoriaProvider, WidgetRef ref) {
    ref.read(categoryProvider.notifier).getData();
    if (categoriaProvider.isEmpty) {
      return const SizedBox();
    }
    final listElement = categoriaProvider
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
          ref.read(entryIdProvider.notifier).update((state) => newState);
        });
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
        onPressed: () {},
        icon: const Icon(Icons.access_time_filled),
        label: Text(
          entry.name!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
