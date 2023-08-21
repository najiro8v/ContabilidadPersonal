import 'package:contabilidad/config/routes/app_routes.dart';
import 'package:contabilidad/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Contabilidad',
      routerConfig: appRoutes,
      theme: AppTheme.lightTheme,
    );
  }
}
