import 'package:flutter/material.dart';

class DrawerItem {
  final IconData icon;
  final String text;
  final int index;
  final Color color;

  DrawerItem({
    required this.icon,
    required this.text,
    required this.index,
    required this.color,
  });
}
