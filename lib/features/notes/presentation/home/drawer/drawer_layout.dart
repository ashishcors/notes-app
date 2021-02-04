import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/app_themes.dart';
import '../../../../../core/widgets/app_logo.dart';
import '../home_controller.dart';

class DrawerLayout extends StatelessWidget {
  final HomeController controller;

  const DrawerLayout(this.controller);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: AppLogo(),
          ),
        ),
        ListTile(
          leading:
              Icon(Get.isDarkMode ? Icons.lightbulb : Icons.lightbulb_outline),
          title: Text(Get.isDarkMode ? "Light Theme" : "Dark Theme"),
          onTap: () {
            Get.changeTheme(Get.isDarkMode ? AppTheme.LIGHT : AppTheme.DARK);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Sign out'),
          onTap: () {
            controller.signOut();
          },
        ),
      ],
    );
  }
}
