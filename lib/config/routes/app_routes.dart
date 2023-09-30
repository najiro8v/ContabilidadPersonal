import 'package:contabilidad/presentations/screens/entries_screen.dart';
import "package:contabilidad/presentations/screens/entry/entry_add_screen.dart";

import "package:flutter/material.dart";

import "package:contabilidad/domain/entities/entities.dart";
import "package:contabilidad/presentations/screens/screens.dart";
import "package:go_router/go_router.dart";

final appRoutes = GoRouter(initialLocation: "/home", routes: [
  GoRoute(
    path: "/home",
    name: "Registros",
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: "/finances",
    name: "Inicio",
    builder: (context, state) => const DataScreen(),
  ),
  GoRoute(
    path: "/Categorias",
    name: "category",
    builder: (context, state) => const UpdateScreen(),
  ),
  GoRoute(
    path: "/Mis_Registros",
    name: "registries",
    builder: (context, state) => const EntriesScreen(),
  ),
  GoRoute(
      path: "/Mis_categorias",
      name: "categoryScreen",
      builder: (context, state) {
        Category? category = state.extra as Category?;
        return CategoryAdd(
          category: category,
        );
      }),
  GoRoute(
      path: "/sub_categorias",
      name: "subcategoryScreen",
      builder: (context, state) {
        Entry? entry = state.extra as Entry?;
        return EntryAdd(
          entry: entry,
        );
      })
]);

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
        screen: const DataScreen())
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
