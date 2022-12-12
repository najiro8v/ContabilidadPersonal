import 'dart:ffi';

import 'package:contabilidad/provider/category_filter_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistriesFilterScreen extends StatelessWidget {
  const RegistriesFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const arrayI = [1, 2, 3, 4, 5, 6];

    final _iconList = <_CustomIcon>[
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
      appBar: AppBar(title: Text("Filtros")),
      body: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: GridView.count(
          semanticChildCount: 2,
          crossAxisCount: 3,
          children: _iconList.map((e) {
            return Container(
              margin: EdgeInsets.all(10),
              child: TextButton.icon(
                  onPressed: () {
                    Provider.of<CategoryFilterProvider>(context, listen: false)
                        .setDescr(e.text);
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
