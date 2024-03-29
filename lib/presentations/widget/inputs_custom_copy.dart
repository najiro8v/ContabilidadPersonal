import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputsCustomEntry extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? idMap;
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

  InputsCustomEntry(
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
      this.padding = 0,
      this.idMap});

  @override
  State<InputsCustomEntry> createState() => _InputsCustomState();
}

class _InputsCustomState extends State<InputsCustomEntry> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    /*
    final provider = Provider.of<DbProvider>(context, listen: false);

    TextEditingController? controller =
        provider.controllerEntryList[widget.idMap!]![widget.propiedad] ??
            TextEditingController(text: widget.initialValue);

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
                      // var valueEntry = provider.valueEntry!.toMap();
                      //valueEntry[widget.propiedad!] = value;
                    }
                  : (value) {
                      //var valueEntry = provider.valueEntry!.toMap();
                      String valor = value.toString();
                      if (valor.isEmpty) return;
                      valor.replaceAll(" ", "");
                      if (valor.contains(",")) {
                        valor = valor.replaceAll(",", ".");
                      }
                      /* valueEntry[widget.propiedad!] =
                          valor.isEmpty ? 0 : double.parse(valor);*/
                    }))),
    );*/
  }
}
