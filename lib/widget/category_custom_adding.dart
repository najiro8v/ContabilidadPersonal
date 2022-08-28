import 'package:contabilidad/widget/inputs_custom_finances.dart';
import "package:flutter/material.dart";

class CategoryCustomAdding extends StatelessWidget {
  final Map<String, String> formProprety;
  final Map<String, dynamic> formValues;
  final double? padding;

  const CategoryCustomAdding(
      {super.key,
      required this.formProprety,
      required this.formValues,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InputsCustomFinances(
              formProprety: formProprety["name"]!, formValues: formValues),
          const SizedBox(
            height: 10,
          ),
          InputsCustomFinances(
              formProprety: formProprety["key"]!, formValues: formValues),
          const SizedBox(
            height: 10,
          ),
          if (formProprety["value"] != null)
            InputsCustomFinances(
              formProprety: formProprety["value"]!,
              formValues: formValues,
              isNumber: true,
              onValueChanges: (value) {
                String valor = value.toString();
                if (valor.isEmpty) return;
                valor.replaceAll(" ", "");
                if (valor.contains(",")) valor = valor.replaceAll(",", ".");
                formValues[formProprety["value"]!] = valor.isEmpty
                    ? 0.toString()
                    : double.parse(valor).toDouble();
              },
            ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
