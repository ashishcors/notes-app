import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/bloc/theme_bloc.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/routing/router.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/utils/app_themes.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _themeBloc = ThemeBloc();

  void getCurrentAppTheme() async {
    _themeBloc.darkMode =
        locator<LocalStorageService>().userPreferences.darkModeEnabled;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentAppTheme();
    return ChangeNotifierProvider(
      create: (_) => _themeBloc,
      child: Consumer<ThemeBloc>(
        builder: (buildContext, value, child) {
          return MaterialApp(
            title: "QNote",
            theme: _themeBloc.darkMode
                ? appThemeData[AppTheme.Dark]
                : appThemeData[AppTheme.Light],
            onGenerateRoute: generateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
            initialRoute: splashRoute,
          );
        },
      ),
    );
  }
}
