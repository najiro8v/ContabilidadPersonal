// ignore_for_file: no_logic_in_create_state

import 'package:contabilidad/widget/inputs_custom_dinamyc.dart';
import 'package:flutter/material.dart';

import "package:contabilidad/controllers/controller.dart";
import 'package:contabilidad/models/models.dart';

class ElementCustomEdit extends StatefulWidget {
  final String label;
  final double? padding;
  final ValueEntry entrie;
  final Future changeList;
  ValueEntry getentrie() {
    return entrie;
  }

  const ElementCustomEdit(
      {super.key,
      this.padding,
      required this.entrie,
      required this.changeList,
      required this.label});

  @override
  State<ElementCustomEdit> createState() => _ElementCustomEditState();
}

class _ElementCustomEditState extends State<ElementCustomEdit> {
  bool isEnable = false;
  ValueEntry? entrie;

  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  Map<String, String> formValues = {
    "key": "",
    "value": "",
    "desc": "",
  };

  @override
  void initState() {
    super.initState();
    entrie = widget.getentrie();
    formValues = {
      "key": "${entrie!.categoryName}",
      "value": "${entrie!.value}",
      "desc": "${entrie!.desc}",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: myFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: InputsCustomDinamyc(
                  initialValue: formValues["key"]!,
                  formValues: formValues,
                  formProprety: "key",
                  labelText: "Llave",
                  enable: false,
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: InputsCustomDinamyc(
                  initialValue: formValues["value"]!,
                  formValues: formValues,
                  formProprety: "value",
                  labelText: "Valor",
                  enable: isEnable,
                  isNumber: true,
                  keyboardType: TextInputType.number,
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 4,
                    child: InputsCustomDinamyc(
                      initialValue: formValues["desc"]!,
                      formValues: formValues,
                      formProprety: "desc",
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
                      Expanded(
                        flex: 3,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: isEnable
                                  ? Colors.teal[700]
                                  : Colors.indigo[900],
                              primary: Colors.indigo.shade100,
                            ),
                            onPressed: () async {
                              isEnable = !isEnable;
                              if (isEnable == true) {
                                setState(() {});
                                return;
                              }
                              var newValueEntry = ValueEntry(
                                  desc: formValues["desc"],
                                  value: double.tryParse(formValues["value"]!),
                                  date: widget.getentrie().date,
                                  latitud: widget.getentrie().latitud,
                                  length: widget.getentrie().length,
                                  type: widget.getentrie().type,
                                  entry: widget.getentrie().entry);

                              await ValueEntryController.update(
                                      newValueEntry, widget.getentrie().id!)
                                  .then((value) => _showToast(
                                      context, "Entrada actualizada con Exito"))
                                  .catchError((onError) =>
                                      _showToast(context, "Entrada con error"));

                              setState(() {});
                            },
                            child: Text(isEnable ? "Guardar" : "Editar")),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                            onPressed: () async {
                              await ValueEntryController.delete(
                                      widget.getentrie().id!)
                                  .then((value) => _showToast(
                                      context, "Entrada eliminada con Exito"))
                                  .catchError((onError) =>
                                      _showToast(context, "Entrada con error"));
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      )
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
      ),
    );
  }
}
