import 'package:contabilidad/routes/setting_routes.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  List<dynamic> data=[];
  @override
  void initState() {
    
    super.initState();

    data=SettingsRoutes.getAppRoutes();

  }
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) => TextButton(
              child:(
                  name: name, route: route, icon: icon, screen: screen)),
          separatorBuilder: (context, index) => Divider(),
          itemCount: 3),
    ));
  }
}
