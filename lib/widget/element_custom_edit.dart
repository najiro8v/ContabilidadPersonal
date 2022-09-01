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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: InputsCustomFinances(
                formValues: widget.formValues,
                formProprety: widget.formProprety["value"]!,
                labelText: "Valor",
                enable: isEnable,
              )),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 4,
                  child: InputsCustomFinances(
                    formValues: widget.formValues,
                    formProprety: widget.formProprety["desc"]!,
                    labelText: "Descrición",
                    enable: isEnable,
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          isEnable ? Colors.teal[700] : Colors.indigo[900],
                      primary: Colors.indigo.shade100,
                    ),
                    onPressed: () {
                      isEnable = !isEnable;
                      setState(() {});
                    },
                    child: Text(isEnable ? "Guardar" : "Editar")),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
