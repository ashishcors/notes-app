import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

///Inspired by https://codepen.io/willhelm/pen/GqBVRA

class ShatterGlass extends StatefulWidget {
  @override
  _ShatterGlassState createState() => _ShatterGlassState();
}

class _ShatterGlassState extends State<ShatterGlass>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  double width;
  double height;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          _controller.reverse();
        else if (status == AnimationStatus.dismissed) _controller.forward();
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: ShatterGlassPainter(_animation.value, width, height),
          );
        },
      ),
    );
  }
}

class ShatterGlassPainter extends CustomPainter {
  ShatterGlassPainter(this.anim, this.screenWidth, this.screenHeight) {
    vertices.add(Offset(screenWidth / 2, screenHeight / 2));
    triangulate(screenWidth / 2, screenHeight / 2);
  }

  final double anim;
  final double screenWidth;
  final double screenHeight;

  final TWO_PI = pi * 2;

  final vertices = List<Offset>();

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawPoints(PointMode.points, vertices, line);
    vertices.forEach((element) {
      print("$element");
//      canvas.drawPoints(
//        Offset(vertices[0][0], vertices[0][1]),
//        Offset(element[0], element[1]),
//        line,
//      );
    });
  }

  @override
  bool shouldRepaint(ShatterGlassPainter oldDelegate) {
    return false;//anim != oldDelegate.anim;
  }

  void triangulate(double centerX, double centerY) {
    final rings = [
      [50, 12],
      [150, 12],
      [300, 12],
      [1200, 12]
    ];
    rings.forEach((element) {
      int radius = element[0];
      int count = element[1];
      double variance = radius * 0.25;
      for (var i = 0; i < count; i++) {
        double x = cos((i / count) * TWO_PI) * radius +
            centerX +
            _randomRange(-variance, variance);
        double y = sin((i / count) * TWO_PI) * radius +
            centerY +
            _randomRange(-variance, variance);
        vertices.add(Offset(x, y));
      }
    });
  }

  double _randomRange(min, max) {
    return min + (max - min) * Random().nextInt(100);
  }

  double _clamp(x, min, max) {
    return x < min ? min : (x > max ? max : x);
  }

  double _sign(x) {
    return x < 0 ? -1 : 1;
  }
}
