import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
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
    await Future.delayed(const Duration(milliseconds: 2000));
    final isLoggedIn = await locator<AuthService>().isUserLoggedIn();
    isLoggedIn
        ? locator<NavigationService>().navigateToClearStack(homeRoute)
        : locator<NavigationService>().navigateToClearStack(loginRoute);
  }
}
