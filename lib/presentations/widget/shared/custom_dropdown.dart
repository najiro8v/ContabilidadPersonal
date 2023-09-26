import 'package:contabilidad/presentations/widget/shared/widget_error_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CustomDropwdownWidget extends ConsumerWidget {
  final FutureProvider<dynamic> providerList;

  final Function(dynamic) onChanged;
  const CustomDropwdownWidget(
      {super.key, required this.providerList, required this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(providerList);

    return provider.when(
        data: (elements) {
          /*final List<DropdownMenuItem> listElement = elements
              .where((element) => element.enable!)
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name!),
                  ))
              .toList();
          return DropdownButtonFormField(
              items: listElement, onChanged: onChanged);*/
          return Column(children: elements.map((e) => Text(e?.name)));
        },
        error: (error, _) => const WidgetErrorAlert(),
        loading: () => Container());
  }
}

/** */