import 'package:flutter/material.dart';

ThemeData temaDia() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(backgroundColor: Colors.blue);
}

ThemeData temaNoche() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(backgroundColor: Colors.blueGrey);
}

ThemeData temaCalido() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(backgroundColor: Colors.lightBlue);
}