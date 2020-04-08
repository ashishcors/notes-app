import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/ui/home/home_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return _getPageRoute(HomePage(), settings);
    case addNote:
      return _getPageRoute(HomePage(), settings);
    case editNote:
      return _getPageRoute(HomePage(), settings);
    case viewNote:
      return _getPageRoute(HomePage(), settings);
    default:
      return _getPageRoute(HomePage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return (MaterialPageRoute(
    settings: settings,
    builder: (context) => child,
  ));
}
