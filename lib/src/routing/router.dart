import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/ui/forgotPassword/frogot_password.dart';
import 'package:notesapp/src/ui/home/home_page.dart';
import 'package:notesapp/src/ui/login/login_page.dart';
import 'package:notesapp/src/ui/register/register_page.dart';
import 'package:notesapp/src/ui/splash/splash_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return _getPageRoute(SplashPage(), settings);
    case homeRoute:
      return _getPageRoute(HomePage(), settings);
    case loginRoute:
      return _getPageRoute(LoginPage(), settings);
    case registerRoute:
      return _getPageRoute(RegisterPage(), settings);
    case forgotPasswordRoute:
      return _getPageRoute(ForgotPasswordPage(), settings);
    case addNote:
      return _getPageRoute(HomePage(), settings);
    case editNote:
      return _getPageRoute(HomePage(), settings);
    case viewNote:
      return _getPageRoute(HomePage(), settings);
    default:
      return _getPageRoute(SplashPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return (MaterialPageRoute(
    settings: settings,
    builder: (context) => child,
  ));
}
