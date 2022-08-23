import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputsCustomFinances extends StatefulWidget {
  const InputsCustomFinances({Key? key}) : super(key: key);

  @override
  State<InputsCustomFinances> createState() => _InputsCustomFinancesState();
}

class _InputsCustomFinancesState extends State<InputsCustomFinances> {
  @override
  Widget build(BuildContext context) {
    return (TextFormField(
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
      initialValue: 100.toString(),
      decoration: const InputDecoration(labelText: "texto"),
      onChanged: (value) {},
    ));
  }
}
