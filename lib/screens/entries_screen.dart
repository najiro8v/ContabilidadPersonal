import 'package:contabilidad/widget/widget.dart';
import 'package:flutter/material.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final Map<String, String> formValues = {
    "desc": "",
    "key": "",
    "value": "",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: myFormKey,
          child: ListView.builder(children: []),
        ),
      ),
    );
  }
}
