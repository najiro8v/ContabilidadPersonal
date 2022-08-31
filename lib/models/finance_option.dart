import 'package:flutter/material.dart';

class FinanceOption {
  FinanceOption(
      {required this.value,
      required this.name,
      required this.icon,
      required this.screen});
  final String value;
  final String name;
  final IconData icon;
  final Widget screen;
}

class subOption {
  final String value;
  final String name;
  subOption({
    required this.value,
    required this.name,
  });
}
