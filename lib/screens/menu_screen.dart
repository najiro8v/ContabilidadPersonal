import 'package:contabilidad/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: AppRoutes.getScreen(_index),
        ),
        bottomNavigationBar: NavigationBar(
            height: 60,
            selectedIndex: _index,
            onDestinationSelected: (value) {
              _index = value;
              setState(() {});
            },
            destinations: [...AppRoutes.getNavigationDestinyties()]));
  }
}
