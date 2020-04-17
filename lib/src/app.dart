import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/routing/router.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';

class App extends StatelessWidget {
  final appThemeLight = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
  final appThemeDark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: "QNote",
      theme: appThemeLight,
      darkTheme: appThemeDark,
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: splashRoute,
    );
  }
}
