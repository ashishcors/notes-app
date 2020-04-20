import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/utils/ui_utils.dart';

import '../locator.dart';
import 'app_logo.dart';

class DrawerLayout extends StatelessWidget {
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
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            locator<NavigationService>().navigateTo(settingsRoute);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Sign out'),
          onTap: () {
            _signOut(context);
          },
        ),
      ],
    );
  }

  void _signOut(BuildContext context) {
    locator<AuthService>().signOut().then((value) {
      locator<NavigationService>().navigateToClearStack(loginRoute);
      locator<LocalStorageService>().clearAllData();
    }).catchError((e) => showMessage(context, e.toString()));
  }
}
