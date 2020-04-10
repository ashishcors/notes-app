import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';

class SplashPage extends StatelessWidget {
  SplashPage() {
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircleAvatar(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Q',
                  style: TextStyle(fontSize: 30),
                ),
                Text('Note')
              ],
            ),
          ),
        ),
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
