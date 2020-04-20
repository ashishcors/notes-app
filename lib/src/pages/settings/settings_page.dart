import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/src/bloc/theme_bloc.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SettingsPageLayout()),
    );
  }
}

class SettingsPageLayout extends StatefulWidget {
  @override
  _SettingsPageLayoutState createState() => _SettingsPageLayoutState();
}

class _SettingsPageLayoutState extends State<SettingsPageLayout> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: locator<LocalStorageService>().userPreferences.darkModeEnabled,
      onChanged: (bool value) {
        setState(
          () {
            Provider.of<ThemeBloc>(context, listen: false).darkMode = value;
            locator<DatabaseService>()
                .addOrUpdateUser(locator<LocalStorageService>().userData)
                .catchError((_) => {});
          },
        );
      },
      secondary: const Icon(Icons.lightbulb_outline),
    );
  }
}
