import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/routing/router.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/utils/app_themes.dart';
import 'package:notesapp/src/viewModel/theme_view_model.dart';
import 'package:notesapp/src/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _themeViewModel = ThemeViewModel();

  void getCurrentAppTheme() async {
    _themeViewModel.darkMode =
        locator<LocalStorageService>().userPreferences.darkModeEnabled;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentAppTheme();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _themeViewModel),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (buildContext, value, child) {
          return MaterialApp(
            title: "QNote",
            theme: _themeViewModel.darkMode
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
