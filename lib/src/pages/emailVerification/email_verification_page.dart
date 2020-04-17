import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: EmailVerificationPageLayout()),
    );
  }
}

class EmailVerificationPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            size: 100,
            color: Colors.orange,
          ),
          Text("Your email is not verifed",
            style: TextStyle(
              fontSize: 15,
            ),),
          MaterialButton(
            onPressed: _sendVerificationEmail,
            child: Text(
              "Send verification email",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendVerificationEmail() {}
}
