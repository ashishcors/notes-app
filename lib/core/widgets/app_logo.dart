import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
