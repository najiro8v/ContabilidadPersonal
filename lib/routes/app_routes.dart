import 'package:contabilidad/screens/entries_screen.dart';
import 'package:contabilidad/screens/settings/settings_screen.dart';
import "package:flutter/material.dart";

import "package:contabilidad/models/models.dart";
import "package:contabilidad/screens/screens.dart";

class AppRoutes {
  static const initalRoute = "home";
  static final menuOptions = <MenuOption>[
    MenuOption(
        name: "Finanzas",
        route: "finances",
        icon: Icons.add_chart_sharp,
        screen: const FinancesScreen()),
    MenuOption(
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
        name: "Configuración",
        route: "configs",
        icon: Icons.add_card_outlined,
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

  static MenuOption getScreen(int index) {
    return menuOptions[index];
  }

  static List<NavigationDestination> getNavigationDestinyties() {
    List<NavigationDestination> iconAppRoutes = [];
    for (final option in menuOptions) {
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
