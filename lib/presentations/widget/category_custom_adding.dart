import './inputs_custom_finances.dart';
import "package:flutter/material.dart";

class CategoryCustomAdding extends StatelessWidget {
  final Map<String, String> formProprety;
  final Map<String, dynamic> formValues;
  final double? padding;

  const CategoryCustomAdding(
      {super.key,
      required this.formProprety,
      required this.formValues,
      this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding!),
      child: Column(
        children: [
          InputsCustomFinances(
              labelText: "Nombre de la categoria",
              formProprety: formProprety["name"]!,
              formValues: formValues),
          const SizedBox(
            height: 10,
          ),
          InputsCustomFinances(
              labelText: "LLave de la categoria",
              formProprety: formProprety["key"]!,
              formValues: formValues),
          const SizedBox(
            height: 10,
          ),
          if (formProprety["value"] != null)
            InputsCustomFinances(
              labelText: "Valor de la categoria",
              formProprety: formProprety["value"]!,
              formValues: formValues,
              isNumber: true,
              initialValue: "0",
              onValueChanges: (value) {
                String valor = value.toString();
                if (valor.isEmpty) return;
                valor.replaceAll(" ", "");
                if (valor.contains(",")) valor = valor.replaceAll(",", ".");
                formValues[formProprety["value"]!] = valor.isEmpty
                    ? 0.toString()
                    : double.parse(valor).toString();
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
