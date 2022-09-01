import 'package:flutter/material.dart';
import 'inputs_custom_finances.dart';

class ElementCustomEdit extends StatefulWidget {
  final Map<String, String> formProprety;
  final String label;
  final Map<String, dynamic> formValues;
  final double? padding;
  const ElementCustomEdit(
      {super.key,
      required this.formProprety,
      required this.formValues,
      this.padding,
      required this.label});

  @override
  State<ElementCustomEdit> createState() => _ElementCustomEditState();
}

class _ElementCustomEditState extends State<ElementCustomEdit> {
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: InputsCustomFinances(
              formValues: widget.formValues,
              formProprety: widget.formProprety["key"]!,
              labelText: "Llave",
              enable: isEnable,
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: InputsCustomFinances(
              formValues: widget.formValues,
              formProprety: widget.formProprety["value"]!,
              labelText: "",
              enable: isEnable,
            )),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: InputsCustomFinances(
              formValues: widget.formValues,
              formProprety: widget.formProprety["desc"]!,
              labelText: "",
              enable: isEnable,
            )),
            TextButton(
                onPressed: () {
                  isEnable = !isEnable;
                  setState(() {});
                },
                child: Text("Editar"))
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
