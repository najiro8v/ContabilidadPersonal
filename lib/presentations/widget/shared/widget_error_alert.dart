import 'package:flutter/material.dart';

class WidgetErrorAlert extends StatelessWidget {
  const WidgetErrorAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).textTheme;
    final screen = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Error en ejecución",
              style: themeColor.titleLarge,
            ),
            Icon(
              Icons.warning_amber_rounded,
              size: screen.size.height * 0.10,
            )
          ]),
    );
  }
}
