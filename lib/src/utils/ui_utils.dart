import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  hideProgress(context);
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void showProgress(BuildContext context, String message) {
  hideProgress(context);
  Scaffold.of(context).showSnackBar(
    SnackBar(
      duration: Duration(days: 365),
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 8),
          Flexible(child: Text(message, softWrap: true)),
        ],
      ),
    ),
  );
}

void hideProgress(BuildContext context) {
  Scaffold.of(context).hideCurrentSnackBar();
}
