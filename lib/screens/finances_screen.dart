import 'package:flutter/material.dart';

import "package:contabilidad/widget/widget.dart";

class FinancesScreen extends StatelessWidget {
  const FinancesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const [InputsCustomFinances()]),
    );
  }
}
