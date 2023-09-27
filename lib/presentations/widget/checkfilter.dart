import 'package:contabilidad/presentations/provider/provider_list_category.dart';
import 'package:flutter/material.dart';
import 'package:contabilidad/domain/entities/models/models.dart' show Entry;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckFilter extends ConsumerStatefulWidget {
  final Entry filter;
  const CheckFilter({Key? key, required this.filter}) : super(key: key);

  @override
  ConsumerState<CheckFilter> createState() => _CheckFilterState();
}

class _CheckFilterState extends ConsumerState<CheckFilter> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            checkColor: Colors.white,
//            fillColor: MaterialStateProperty.resolveWith(),
            value: isChecked,
            onChanged: (value) async {},
          ),
          TextButton(
              onPressed: () {
                ref.read(valueEntryProvider.notifier).getData();
              },
              child: Text(
                widget.filter.name!,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      ),
    );
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
