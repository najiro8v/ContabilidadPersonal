import "package:contabilidad/screens/settings/settings.dart";
import "package:contabilidad/models/models.dart";
import "package:flutter/material.dart";

class SettingsRoutes {
  static const initalRoute = "home";
  static final menuOptions = <MenuOption>[
    MenuOption(
        name: "Entradas",
        route: "entries",
        icon: Icons.align_vertical_bottom_sharp,
        screen: const UpdateScreen()),
    MenuOption(
        name: "Configuración",
        route: "configs",
        icon: Icons.add_card_outlined,
        screen: const AddingScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
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
