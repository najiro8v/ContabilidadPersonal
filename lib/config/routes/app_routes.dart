import 'package:contabilidad/presentations/screens/entries_screen.dart';
import 'package:contabilidad/presentations/screens/settings/settings_screen.dart';
import "package:flutter/material.dart";

import "package:contabilidad/domain/entities/models/models.dart";
import "package:contabilidad/presentations/screens/screens.dart";

class AppRoutes {
  static const initalRoute = "home";
  static final menuOptions = <MenuOption>[
    MenuOption(
        menuPrincipal: true,
        name: "Registros",
        route: "entries",
        icon: Icons.monetization_on_outlined,
        screen: const FinancesScreen()),
    MenuOption(
        menuPrincipal: true,
        name: "Inicio",
        route: "finances",
        icon: Icons.home,
        screen: const DataScreen()),
    MenuOption(
        menuPrincipal: true,
        name: "Configuración",
        route: "configs",
        icon: Icons.settings,
        screen: const SettingsScreen()),
    MenuOption(
        name: "Categorias",
        route: "category",
        icon: Icons.align_vertical_bottom_sharp,
        screen: const UpdateScreen()),
    MenuOption(
        name: "Mis Registros",
        route: "registries",
        icon: Icons.align_vertical_bottom_sharp,
        screen: const EntriesScreen()),
    MenuOption(
        name: "Mis Registros",
        route: "categoryScreen",
        icon: Icons.align_vertical_bottom_sharp,
        screen: const CategoryAdd()),
    MenuOption(
        name: "Mis Registros",
        route: "subcategoryScreen",
        icon: Icons.align_vertical_bottom_sharp,
        screen: const SubCategoryAdd()),
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
