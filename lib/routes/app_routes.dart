import 'package:contabilidad/screens/entries_screen.dart';
import 'package:contabilidad/screens/settings/settings_screen.dart';
import "package:flutter/material.dart";

import "package:contabilidad/models/models.dart";
import "package:contabilidad/screens/screens.dart";

class AppRoutes {
  static const initalRoute = "home";
  static final menuOptions = <MenuOption>[
    MenuOption(
        menuPrincipal: true,
        name: "Finanzas",
        route: "finances",
        icon: Icons.add_chart_sharp,
        screen: const FinancesScreen()),
    MenuOption(
        menuPrincipal: true,
        name: "Depositos",
        route: "deposit",
        icon: Icons.monetization_on_outlined,
        screen: const DataScreen()),
    MenuOption(
        name: "Entradas",
        route: "entries",
        icon: Icons.align_vertical_bottom_sharp,
        screen: const EntriesScreen()),
    MenuOption(
        menuPrincipal: true,
        name: "Configuración",
        route: "configs",
        icon: Icons.settings,
        screen: const SettingsScreen())
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  static MenuOption getScreen(int index, {all = true}) {
    return _actualMenu(all)[index];
  }

  static List<MenuOption> _actualMenu(bool all) {
    return all
        ? menuOptions
        : menuOptions.where((e) => e.menuPrincipal == true).toList();
  }

  static List<NavigationDestination> getNavigationDestinyties(
      {bool all = true}) {
    List<NavigationDestination> iconAppRoutes = [];
    for (final option in _actualMenu(all)) {
      iconAppRoutes.addAll({
        NavigationDestination(
            icon: Icon(option.icon),
            selectedIcon: Icon(option.icon),
            label: option.name)
      });
    }
    return iconAppRoutes;
  }
}
