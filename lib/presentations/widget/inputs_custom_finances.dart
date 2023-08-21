import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class InputsCustomFinances extends StatefulWidget {
  final String formProprety;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final bool? isNumber;
  final bool? enable;
  final IconData? icon;
  final IconData? iconSuffix;
  final TextInputType? keyboardType;
  final Map<String, dynamic> formValues;
  String initialValue;
  final double? padding;
  set text(dynamic x) {
    initialValue = x.toString();
  }

  final Function(String)? onValueChanges;
  InputsCustomFinances(
      {super.key,
      required this.formProprety,
      required this.formValues,
      this.initialValue = "",
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
  State<InputsCustomFinances> createState() => _InputsCustomFinancesState();
}

class _InputsCustomFinancesState extends State<InputsCustomFinances> {
  _InputsCustomFinancesState();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding!),
      child: (TextFormField(
          controller: TextEditingController()
            ..text = widget.isNumber != null &&
                    widget.isNumber! &&
                    widget.initialValue.isNotEmpty
                ? double.parse(widget.initialValue).toString()
                : widget.initialValue,
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
                      widget.formValues[widget.formProprety] = value;
                      widget.text = value;
                    }
                  : (value) {
                      String valor = value.toString();
                      if (valor.isEmpty) return;
                      valor.replaceAll(" ", "");
                      if (valor.contains(",")) {
                        valor = valor.replaceAll(",", ".");
                      }
                      widget.formValues[widget.formProprety] = valor.isEmpty
                          ? 0.toString()
                          : double.parse(valor).toString();
                    }))),
    );
  }
}
