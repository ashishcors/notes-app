import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/routing/router.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';

class App extends StatelessWidget {
  final appThemeLight = ThemeData.light();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QNote",
      theme: appThemeLight,
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute:
          locator<AuthService>().isUserLoggedIn ? homeRoute : loginRoute,
    );
  }
}
