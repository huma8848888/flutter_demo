import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  static double radius = 10.0;
  List<FallingBall> rainFall;

  MyPainter(this.rainFall);

  @override
  void paint(Canvas canvas, Size size) {
    rainFall.forEach((element) {
      element.fall();
      canvas.drawCircle(Offset(element.x, element.y), radius,
          Paint()..color = Colors.amberAccent);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class FallingBall {
  double x = Random().nextDouble() * 400;
  double y = 10;
  double velocity = Random().nextDouble() * 4 + 2;

  void fall() {
    y += velocity;
    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 400;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}
