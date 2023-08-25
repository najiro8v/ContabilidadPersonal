import 'package:contabilidad/presentations/provider/db_provider.dart';
import 'inputs_custom_value_entry.dart';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

//import 'package:contabilidad/models/models.dart';

// ignore: must_be_immutable
class ElementCustomEditValueEntry extends StatefulWidget {
  final String label;
  final double? padding;
  final dynamic obj;

  Function update = () => {};
  Function delete = () => {};
  ElementCustomEditValueEntry({
    super.key,
    this.padding,
    required this.obj,
    required this.label,
    required deleteFunction,
    required updateFunction,
  }) {
    update = updateFunction;
    delete = deleteFunction;
  }

  @override
  State<ElementCustomEditValueEntry> createState() => _ElementCustomEditState();
}

class _ElementCustomEditState extends State<ElementCustomEditValueEntry> {
  bool isEnable = false;

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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbProvider>(context);
    final idObj = widget.obj["id"].toString();
    final obj = widget.obj;
    if (provider.controllerValueEntryList.containsKey(idObj) == false) {
      var controllerDesc = TextEditingController(text: obj["desc"]);
      var controllerValue =
          TextEditingController(text: obj["value"].toString());

      TextEditingController(text: obj["value"].toString());
      Map<String, Map<String, TextEditingController?>> mapa = {
        idObj: {"value": controllerValue, "desc": controllerDesc}
      };
      provider.controllerValueEntryList.addAll(mapa);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: myFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: InputsCustomValueEntry(
                  idMap: idObj,
                  propiedad: "entry_id",
                  initialValue: obj["entry_id"].toString(),
                  labelText: "Llave",
                  enable: false,
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: InputsCustomValueEntry(
                  idMap: idObj,
                  labelText: "Valor",
                  enable: isEnable,
                  initialValue: obj["value"].toString(),
                  propiedad: "value",
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
                    child: InputsCustomValueEntry(
                      idMap: idObj,
                      propiedad: "desc",
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
                                //int id = widget.obj is Map ? obj["id"] : obj.id;
                                await widget.update(obj, context);
                                //await widget.emitFunction;
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
                              int id = obj is Map ? obj["id"] : obj.id;
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
