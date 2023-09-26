import 'package:flutter/material.dart';
import 'package:contabilidad/domain/entities/models/models.dart' show Entry;

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
    return Placeholder();
    /*
    var provider = Provider.of<DbProvider>(context);
    checkFun() async {
      if ((!isChecked) == true) {
        await provider.addFilter(widget.filter.id.toString());
        await provider.getValueEntries();
      } else {
        await provider.removeFilter(widget.filter.id.toString());
      }
      setState(() {
        isChecked = !isChecked;
      });
    }

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.indigo;
    }

    return InkWell(
      onTap: checkFun,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (value) async {
              await checkFun();
            },
          ),
          TextButton(
              onPressed: checkFun,
              child: Text(
                widget.filter.name!,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      ),
    );*/
  }
}
