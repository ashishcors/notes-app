import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;

  CustomTextField(
      {Key key,
      this.labelText,
      this.controller,
      this.obscureText = false,
      this.keyboardType,
      this.textInputAction,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        labelText: labelText,
      ),
    );
  }
}
