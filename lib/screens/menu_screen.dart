import 'package:contabilidad/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final destinationRoutes = AppRoutes.getNavigationDestinyties();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text(AppRoutes.getScreenMenus(_index).name)),
        body: Center(
          child: AppRoutes.getScreenMenus(_index).screen,
        ),
        bottomNavigationBar: NavigationBar(
            height: 60,
            selectedIndex: _index,
            onDestinationSelected: (value) {
              destinationRoutes[value];
              if (AppRoutes.getScreenMenus(value).route == "configs") {
                _scaffoldKey.currentState!.openEndDrawer();
              } else {
                _index = value;
              }
              setState(() {});
            },
            destinations: destinationRoutes),
        endDrawer: Drawer(
          child: Container(color: Colors.red),
        ));
  }
}
