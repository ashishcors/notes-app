import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  bool goBack() {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
      return true;
    } else {
      return false;
    }
  }
}
