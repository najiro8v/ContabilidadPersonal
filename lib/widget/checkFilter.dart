import 'package:contabilidad/models/models.dart';
import 'package:flutter/material.dart';

class CheckFilter extends StatefulWidget {
  final Entry filter;
  const CheckFilter({Key? key, required this.filter}) : super(key: key);

  @override
  State<CheckFilter> createState() => _CheckFilterState();
}

class _CheckFilterState extends State<CheckFilter> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Column(
      children: [
        Text(widget.filter.name!),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
      ],
    );
  }
}
