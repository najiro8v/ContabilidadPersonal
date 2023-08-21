import 'package:flutter/material.dart' show IconData, Widget;

class MenuOption {
  MenuOption(
      {required this.name,
      required this.route,
      required this.icon,
      required this.screen,
      this.menuPrincipal = false});
  final String name;
  final String route;
  final IconData icon;
  final Widget screen;
  final bool menuPrincipal;
}
