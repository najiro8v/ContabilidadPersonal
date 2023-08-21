import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;
  static Color secondary = Colors.indigo.shade100;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(color: primary),
      navigationBarTheme: const NavigationBarThemeData().copyWith(
          elevation: 10,
          backgroundColor: primary,
          labelTextStyle:
              MaterialStateProperty.all(TextStyle(color: secondary)),
          iconTheme:
              MaterialStateProperty.all(IconThemeData(color: secondary))),
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(primary: secondary, backgroundColor: primary),
      ));
}
