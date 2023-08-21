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

class SubOption {
  final String value;
  final String name;
  final String? desc;
  SubOption({
    required this.value,
    required this.name,
    this.desc,
  });
}
