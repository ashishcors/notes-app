import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/models/user.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/widgets/app_logo.dart';

class SplashPage extends StatelessWidget {
  SplashPage() {
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppLogo(),
      ),
    );
  }

  void _navigate() async {
    final isLoggedIn = await locator<AuthService>().isUserLoggedIn();
    isLoggedIn
        ? _fetchUserData()
        : {
            await Future.delayed(const Duration(milliseconds: 2000)),
            locator<NavigationService>().navigateToClearStack(loginRoute)
          };
  }

  void _fetchUserData() async {
    final userId = locator<AuthService>().firebaseUser.uid;
    locator<DatabaseService>().getUser(userId).then((value) {
      locator<LocalStorageService>().userData = User.fromJson(value.data);
      locator<NavigationService>().navigateToClearStack(homeRoute);
    }).catchError(
        (_) => locator<NavigationService>().navigateToClearStack(homeRoute));
  }
}
