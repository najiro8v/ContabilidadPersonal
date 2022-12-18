// ignore_for_file: no_logic_in_create_state

import 'package:contabilidad/widget/inputs_custom_dinamyc.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
//import 'package:contabilidad/models/models.dart';

// ignore: must_be_immutable
class ElementCustomEdit extends StatefulWidget {
  final String label;
  final double? padding;
  final Object obj;
  final Future emitFunction;
  Object getObj() {
    return obj;
  }

  Function update = () => {};
  Function delete = () => {};
  ElementCustomEdit({
    super.key,
    this.padding,
    required this.obj,
    required this.emitFunction,
    required this.label,
    required deleteFunction,
    required updateFunction,
  }) {
    update = updateFunction;
    delete = deleteFunction;
  }

  @override
  State<ElementCustomEdit> createState() => _ElementCustomEditState();
}

class _ElementCustomEditState extends State<ElementCustomEdit> {
  bool isEnable = false;
  dynamic obj;

  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  void _showToast(BuildContext context, String message, {isError = false}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? Colors.deepOrangeAccent[400] : Colors.green[600],
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
    obj = widget.getObj();
    formValues = {
      "key": "${obj is! Map ? obj!.categoryName : obj!["key"]}",
      "value": "${obj is! Map ? obj!.value : obj!["value"]}",
      "desc": "${obj is! Map ? obj!.desc : obj!["name"]}",
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
                  flex: 3,
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
                              String msg = "Registro actualizado con Exito";
                              bool isError = false;
                              try {
                                int id = obj is Map ? obj!["id"] : obj.id;
                                await widget.update(obj, id, formValues);
                                await widget.emitFunction;
                              } catch (e) {
                                // print(e);
                                msg = "Error en actualización de registro";
                                isError = true;
                              } finally {
                                _showToast(context, msg, isError: isError);
                                setState(() {});
                              }
                            },
                            child: Text(isEnable ? "Guardar" : "Editar")),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                          style:
                              TextButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () async {
                            String msg = "Registro eliminado con Exito";
                            bool isError = false;
                            try {
                              int id = obj is Map ? obj!["id"] : obj.id;
                              await widget.delete(id, context);
                              // await widget.emitFunction;
                            } catch (e) {
                              developer.log('log me', name: 'my.app.category');
                              msg = "Error en eliminación de registro";
                              isError = true;
                            } finally {
                              _showToast(context, msg, isError: isError);
                              //setState(() {});
                            }
                          },
                          child: const Icon(Icons.delete, size: 25),
                        ),
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
