import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/bloc/theme_bloc.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/models/user.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/widgets/app_logo.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _navigate(context);
    return Scaffold(
      body: Center(
        child: AppLogo(),
      ),
    );
  }

  void _navigate(BuildContext context) async {
    final isLoggedIn = await locator<AuthService>().isUserLoggedIn();
    isLoggedIn
        ? _fetchUserData(context)
        : {
            await Future.delayed(const Duration(milliseconds: 2000)),
            locator<LocalStorageService>().clearAllData(),
            locator<NavigationService>().navigateToClearStack(loginRoute)
          };
  }

  void _fetchUserData(BuildContext context) async {
    final userId = locator<AuthService>().firebaseUser.uid;
    locator<DatabaseService>().getUser(userId).then((value) {
      locator<LocalStorageService>().userData = User.fromJson(value.data);
      Provider.of<ThemeBloc>(context, listen: false).darkMode =
          locator<LocalStorageService>().userPreferences.darkModeEnabled;
      locator<NavigationService>().navigateToClearStack(homeRoute);
    }).catchError(
        (_) => locator<NavigationService>().navigateToClearStack(homeRoute));
  }
}
