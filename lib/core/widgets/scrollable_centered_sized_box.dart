import 'package:flutter/material.dart';

class ScrollableCenteredSizedBox extends StatelessWidget {
  final Widget child;

  ScrollableCenteredSizedBox({this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width:
              (MediaQuery.of(context).size.width < 600) ? double.infinity : 600,
          height: MediaQuery.of(context).size.height,
          child: child,
        ),
      ),
    );
  }
}
