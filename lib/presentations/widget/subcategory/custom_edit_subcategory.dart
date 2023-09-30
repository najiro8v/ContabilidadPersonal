import 'package:contabilidad/domain/entities/models/models.dart';
import 'package:contabilidad/presentations/widget/inputs/input_custom.dart';
import 'package:flutter/material.dart';

class CustomEditSubCategory extends StatefulWidget {
  final Future<dynamic> Function(dynamic)? update;
  final Future<dynamic> Function(dynamic)? delete;
  final Entry entry;
  const CustomEditSubCategory(
      {super.key,
      required this.delete,
      required this.update,
      required this.entry});

  @override
  State<CustomEditSubCategory> createState() => _CustomEditSubCategorytate();
}

class _CustomEditSubCategorytate extends State<CustomEditSubCategory> {
  bool isEnable = false;

  final inputControllerDesc = TextEditingController();
  final inputControllerValue = TextEditingController();

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
  void dispose() {
    inputControllerDesc.dispose();
    inputControllerValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inputControllerDesc.text = widget.entry.name.toString();
    inputControllerValue.text = widget.entry.value.toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: myFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: WidgetInputsCustom(
                  controller: inputControllerDesc,
                  labelText: "Descripción",
                  keyboardType: TextInputType.text,
                  enable: isEnable,
                  onChanged: (value) {},
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 4,
                    child: WidgetInputsCustom(
                      controller: inputControllerValue,
                      labelText: "Valor",
                      keyboardType: TextInputType.number,
                      enable: isEnable,
                      onChanged: (value) {},
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
                            ),
                            onPressed: () async {
                              isEnable = !isEnable;
                              if (isEnable == true) {
                                setState(() {});
                                return;
                              }
                              final price =
                                  double.tryParse(inputControllerValue.text) ??
                                      0;
                              final newEntry = widget.entry.copyWith(
                                  value: price, name: inputControllerDesc.text);
                              widget.update!(newEntry);
                              String msg = "Registro actualizado con Exito";
                              bool isError = false;
                              try {} catch (e) {
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
                              widget.delete!(widget.entry);
                            } catch (e) {
                              msg = "Error en eliminación de registro";
                              isError = true;
                            } finally {
                              _showToast(context, msg, isError: isError);
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
