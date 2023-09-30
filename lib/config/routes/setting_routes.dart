import "package:contabilidad/presentations/screens/settings/settings.dart";
import "package:contabilidad/domain/entities/entities.dart";
import "package:flutter/material.dart";

class SettingsRoutes {
  static const initalRoute = "home";
  static final menuOptions = <MenuOption>[
    MenuOption(
        name: "Editar categorias",
        route: "editcateg",
        icon: Icons.align_vertical_bottom_sharp,
        screen: const UpdateScreen()),
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
