import 'package:flutter/material.dart';

class InputsCustomFinances extends StatelessWidget {
  const InputsCustomFinances({Key? key}) : super(key: key);
  final bool isEnableText = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text("Button"),
        ),
        Checkbox(value: false, onChanged: (value) {}),
        Expanded(
          child: TextFormField(
            onChanged: isEnableText ? (value) {} : null,
          ),
        )
      ],
    );
  }
}
