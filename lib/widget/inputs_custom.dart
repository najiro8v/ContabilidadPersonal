import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:contabilidad/provider/providers.dart';

// ignore: must_be_immutable
class InputsCustom extends StatelessWidget {
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
  set text(dynamic x) {
    initialValue = x.toString();
  }

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
  Widget build(BuildContext context) {
    final bd = Provider.of<DbProvider>(context, listen: false);
    var valueEntry = bd.valueEntry!.toMap();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding!),
      child: (TextFormField(
          controller: TextEditingController(
              text: isNumber != null && isNumber!
                  ? valueEntry[propiedad!].toString()
                  : valueEntry[propiedad!].toString()),
          inputFormatters: isNumber!
              ? [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*$'))]
              : [],
          validator: ((value) {
            if (value == null || value.isEmpty) {
              return "este campo es requerido";
            }
            return null;
          }),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            helperText: helperText,
            suffixIcon: iconSuffix == null ? null : Icon(iconSuffix),
            icon: icon == null ? null : Icon(icon),
          ),
          enabled: enable,
          onChanged: onValueChanges ??
              (isNumber != null && isNumber != true
                  ? (value) {
                      valueEntry[propiedad!] = value;
                      text = value;
                    }
                  : (value) {
                      String valor = value.toString();
                      if (valor.isEmpty) return;
                      valor.replaceAll(" ", "");
                      if (valor.contains(",")) {
                        valor = valor.replaceAll(",", ".");
                      }
                      valueEntry[propiedad!] =
                          valor.isEmpty ? 0 : double.parse(valor);
                    }))),
    );
  }
}
