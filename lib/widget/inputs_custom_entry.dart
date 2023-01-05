import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:contabilidad/provider/providers.dart';
import "package:contabilidad/models/models.dart" show ValueEntry;

// ignore: must_be_immutable
class InputsCustom extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? propiedad;
  final String? respaldo;
  final bool? isNumber;
  final bool? enable;
  final IconData? icon;
  final IconData? iconSuffix;
  final TextInputType? keyboardType;
  String initialValue;
  final double? padding;
  final Function(String)? onValueChanges;

  InputsCustom(
      {super.key,
      this.initialValue = "",
      this.propiedad = "",
      this.respaldo,
      this.isNumber = false,
      this.hintText,
      this.labelText,
      this.helperText,
      this.icon,
      this.iconSuffix,
      this.keyboardType,
      this.onValueChanges,
      this.enable = true,
      this.padding = 0});

  @override
  State<InputsCustom> createState() => _InputsCustomState();
}

class _InputsCustomState extends State<InputsCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bd = Provider.of<DbProvider>(context, listen: false);

    TextEditingController? controller = bd.controllerCategory[widget.propiedad];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding!),
      child: (TextFormField(
          controller: controller,
          inputFormatters: widget.isNumber!
              ? [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*$'))]
              : [],
          validator: ((value) {
            if (value == null || value.isEmpty) {
              return "este campo es requerido";
            }
            return null;
          }),
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            helperText: widget.helperText,
            suffixIcon:
                widget.iconSuffix == null ? null : Icon(widget.iconSuffix),
            icon: widget.icon == null ? null : Icon(widget.icon),
          ),
          enabled: widget.enable,
          onChanged: widget.onValueChanges ??
              (widget.isNumber != null && widget.isNumber != true
                  ? (value) {
                      var valueEntry = bd.valueEntry!.toMap();
                      valueEntry[widget.propiedad!] = value;
                      bd.valueEntry = ValueEntry.fromMap(valueEntry);
                    }
                  : (value) {
                      var valueEntry = bd.valueEntry!.toMap();
                      String valor = value.toString();
                      if (valor.isEmpty) return;
                      valor.replaceAll(" ", "");
                      if (valor.contains(",")) {
                        valor = valor.replaceAll(",", ".");
                      }
                      valueEntry[widget.propiedad!] =
                          valor.isEmpty ? 0 : double.parse(valor);
                      bd.valueEntry = ValueEntry.fromMap(valueEntry);
                    }))),
    );
  }
}
