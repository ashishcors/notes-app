import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Light: ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  ),
  AppTheme.Dark: ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
    ),
  ),
};
