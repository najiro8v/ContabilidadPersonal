import 'package:contabilidad/provider/category_filter_provider.dart';
import 'package:contabilidad/provider/db_provider.dart';
import 'package:contabilidad/themes/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:contabilidad/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryFilterProvider(initialDate: DateTime.now()),
        ),
        ChangeNotifierProvider(
          create: (_) => DbProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contabilidad',
        initialRoute: AppRoutes.initalRoute,
        routes: AppRoutes.getAppRoutes(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
