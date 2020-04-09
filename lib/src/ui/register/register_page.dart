import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/src/models/user.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/auth_service.dart';
import 'package:notesapp/src/services/database_service.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/utils/ui_utils.dart';

import '../../locator.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterLayout(),
    );
  }
}

class RegisterLayout extends StatefulWidget {
  @override
  _RegisterLayoutState createState() => _RegisterLayoutState();
}

class _RegisterLayoutState extends State<RegisterLayout> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputFieldDecoration = InputDecoration(
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: (MediaQuery.of(context).size.width < 600)
                ? double.infinity
                : 600,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Register', style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                SizedBox(
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
                SizedBox(height: 30),
                TextField(
                  controller: _nameTextController,
                  decoration: inputFieldDecoration.copyWith(
                    hintText: 'Name',
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _emailTextController,
                  decoration: inputFieldDecoration.copyWith(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  decoration: inputFieldDecoration.copyWith(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () => _registerUser(),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser() {
    String name = _nameTextController.text.trim();
    String email = _emailTextController.text.trim();
    String password = _passwordTextController.text.trim();
    showProgress(context, 'Creating Account...');
    locator<AuthService>()
        .registerUser(name, email, password)
        .then((value) => locator<DatabaseService>().addOrUpdateUser(
              User(
                userId: value.uid,
                displayName: name,
                emailId: email,
              ),
            ))
        .then((value) => {
              locator<NavigationService>().navigateToClearStack(homeRoute)
            })
        .catchError((e) => {
              (e is PlatformException)
                  ? showMessage(context, e.message)
                  : showMessage(context, 'An error has occurred.')
            });
  }
}
