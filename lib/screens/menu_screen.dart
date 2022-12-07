import 'package:contabilidad/routes/app_routes.dart';
import 'package:contabilidad/widget/widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final destinationRoutes = AppRoutes.getNavigationDestinyties(all: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar:
            AppBar(title: Text(AppRoutes.getScreen(_index, all: false).name)),
        body: Center(
          child: AppRoutes.getScreen(_index, all: false).screen,
        ),
        bottomNavigationBar: NavigationBar(
            height: 60,
            selectedIndex: _index,
            onDestinationSelected: (value) {
              destinationRoutes[value];
              if (AppRoutes.getScreen(value, all: false).route == "configs") {
                _scaffoldKey.currentState!.openEndDrawer();
              } else {
                _index = value;
              }
              setState(() {});
            },
            destinations: destinationRoutes),
        endDrawer: const CustomDrawer());
  }
}
