import 'package:flutter/material.dart';

class WidgetInputsCustom extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final bool? enable;
  final IconData? icon;
  final IconData? iconSuffix;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final double? padding;
  final Function(String)? onChanged;

  const WidgetInputsCustom(
      {super.key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.icon,
      this.iconSuffix,
      this.keyboardType,
      this.onChanged,
      this.enable = true,
      required this.controller,
      this.padding = 0});

  @override
  State<WidgetInputsCustom> createState() => _InputsCustomState();
}

class _InputsCustomState extends State<WidgetInputsCustom> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding!),
      child: (TextFormField(
        controller: _controller,
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
        onChanged: widget.onChanged,
      )),
    );
  }
}
