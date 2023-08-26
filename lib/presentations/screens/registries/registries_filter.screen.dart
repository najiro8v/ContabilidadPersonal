import 'package:contabilidad/presentations/provider/providers.dart';
import 'package:flutter/material.dart';

class RegistriesFilterScreen extends StatelessWidget {
  const RegistriesFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final iconList = <_CustomIcon>[
      _CustomIcon(icon: Icons.cake, text: "cake"),
      _CustomIcon(icon: Icons.add_location_sharp, text: "localition"),
      _CustomIcon(icon: Icons.zoom_in_outlined, text: "zoom"),
      _CustomIcon(icon: Icons.auto_awesome_motion, text: "auto"),
      _CustomIcon(icon: Icons.call_end_sharp, text: "call"),
      _CustomIcon(icon: Icons.equalizer_rounded, text: "equa"),
      _CustomIcon(icon: Icons.wifi_lock, text: "wifi"),
      _CustomIcon(icon: Icons.mail, text: "mail"),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Filtros")),
      body: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: GridView.count(
          semanticChildCount: 2,
          crossAxisCount: 3,
          children: iconList.map((e) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: TextButton.icon(
                  onPressed: () {
                    //   Provider.of<DbProvider>(context, listen: false).descr =
                    //     e.text;
                    Navigator.pop(context);
                  },
                  icon: Icon(e.icon),
                  label: Text(e.text)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _CustomIcon {
  IconData icon;
  String text;
  _CustomIcon({required this.icon, required this.text});
}
