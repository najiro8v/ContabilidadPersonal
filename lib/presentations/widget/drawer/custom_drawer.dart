import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(
      height: 20,
    );
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          const _OptionConfig(
            text: "Categorias",
            route: "/Categorias",
            icon: Icons.people_outline,
          ),
          space,
          const _OptionConfig(
            text: "Mis Registros",
            route: "/Mis_Registros",
            icon: Icons.people_outline,
          ),
          space,
          _OptionConfig(
            text: "Perfil",
            event: () {},
            icon: Icons.people_outline,
          ),
          space,
          _OptionConfig(
            text: "Cerrar Sesión",
            event: () async {
              SystemNavigator.pop();
            },
            icon: Icons.people_outline,
          ),
        ],
      ),
    );
  }
}

class _OptionConfig extends StatelessWidget {
  const _OptionConfig({
    this.event,
    required this.icon,
    required this.text,
    this.route,
    Key? key,
  }) : super(key: key);
  final VoidCallback? event;
  final String text;
  final String? route;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: event ??
          (() {
            Scaffold.of(context).hasEndDrawer
                ? Scaffold.of(context).closeEndDrawer()
                : null;
            context.push(route ?? "/home");
          }),
    );
  }
}
