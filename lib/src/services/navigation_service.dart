import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic argument}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToClearStack(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (r) => false);
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
