import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/scrollable_centered_sized_box.dart';
import 'signup_controller.dart';

class SignupPage extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScrollableCenteredSizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Register', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              AppLogo(),
              SizedBox(height: 30),
              CustomTextField(
                controller: controller.nameTextController,
                labelText: 'Name',
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              SizedBox(height: 8),
              CustomTextField(
                controller: controller.emailTextController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              SizedBox(height: 8),
              CustomTextField(
                controller: controller.passwordTextController,
                obscureText: true,
                labelText: 'Password',
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _signupUser(),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: MaterialButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () => _signupUser(),
                  child: Text(
                    'SIGNUP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signupUser() {
    controller.signup();
  }
}
