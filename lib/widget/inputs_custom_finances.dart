import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputsCustomFinances extends StatelessWidget {
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
  final String? initialValue;
  final double? padding;

  final Function(String)? onValueChanges;
  const InputsCustomFinances(
      {Key? key,
      required this.formProprety,
      required this.formValues,
      this.initialValue,
      this.isNumber = false,
      this.hintText,
      this.labelText,
      this.helperText,
      this.icon,
      this.iconSuffix,
      this.keyboardType,
      this.onValueChanges,
      this.enable = true,
      this.padding = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding!),
      child: (TextFormField(
        inputFormatters: isNumber!
            ? [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))]
            : [],
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return "este campo es requerido";
          }
          return null;
        }),
        initialValue: isNumber != null && isNumber!
            ? double.parse(initialValue!).toString()
            : "",
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          suffixIcon: iconSuffix == null ? null : Icon(iconSuffix),
          icon: icon == null ? null : Icon(icon),
        ),
        enabled: enable,
        onChanged: onValueChanges ??
            (value) {
              formValues[formProprety] = value;
            },
      )),
    );
  }
}
