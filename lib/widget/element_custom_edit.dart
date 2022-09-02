// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'inputs_custom_finances.dart';
import "package:contabilidad/controllers/controller.dart";

class ElementCustomEdit extends StatefulWidget {
  final Map<String, String> formProprety;
  final String label;
  final Map<String, dynamic> formValues;
  final double? padding;
  final int? id;
  final int index;
  final Future<void> changeList;
  const ElementCustomEdit(
      {super.key,
      required this.formProprety,
      required this.formValues,
      this.padding,
      required this.label,
      required this.index,
      this.id,
      required this.changeList});

  @override
  State<ElementCustomEdit> createState() => _ElementCustomEditState(
      formProprety, formValues, label, padding, index, id!);
}

class _ElementCustomEditState extends State<ElementCustomEdit> {
  bool isEnable = false;
  _ElementCustomEditState(this.formProprety, this.formValues, this.label,
      this.padding, this.index, this.id);
  final Map<String, String> formProprety;
  final String? label;
  final Map<String, dynamic> formValues;
  final double? padding;
  final int index;
  final int id;
  @override
  void initState() {
    super.initState();
  }

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
                initialValue: widget.formProprety["key$index"],
                formValues: widget.formValues,
                formProprety: "key$index",
                labelText: "Llave",
                enable: false,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: InputsCustomFinances(
                initialValue: widget.formProprety["value$index"],
                formValues: widget.formValues,
                formProprety: "value$index",
                labelText: "Valor",
                enable: isEnable,
                isNumber: true,
                keyboardType: TextInputType.number,
                onValueChanges: (value) {
                  String valor = value.toString();
                  if (valor.isEmpty) return;
                  valor.replaceAll(" ", "");
                  if (valor.contains(",")) valor = valor.replaceAll(",", ".");
                  formProprety["value$index"] = valor.isEmpty
                      ? 0.toString()
                      : double.parse(valor).toString();
                },
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
                    initialValue: widget.formProprety["desc$index"]!,
                    formValues: widget.formValues,
                    formProprety: "desc$index",
                    labelText: "Descrición",
                    enable: isEnable,
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    TextButton(
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
                    TextButton(
                        onPressed: () async {
                          await ValueEntryController.delete(id);
                          await widget.changeList;
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
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
