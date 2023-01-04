import 'package:flutter/material.dart';
import "package:contabilidad/routes/setting_routes.dart";

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: const Text("Categorias")),
      body: ListView.separated(
          itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SettingsRoutes.getScreen(index).screen));
                    },
                    child: (Text(SettingsRoutes.getScreen(index).name))),
              ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 2),
    ));
  }
}
