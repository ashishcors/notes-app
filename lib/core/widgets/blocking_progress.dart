import 'dart:ui';

import 'package:flutter/material.dart';

class BlockingProgress extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const BlockingProgress({Key key, this.isLoading, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: isLoading,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(.1),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        )
      ],
    );
  }
}
