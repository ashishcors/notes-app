import 'package:flutter/material.dart';

class AppTheme {
  static final LIGHT = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
  static final DARK = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
