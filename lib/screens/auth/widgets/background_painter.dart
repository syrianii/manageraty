import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:user_managment/config/palette.dart';
import 'package:flutter/animation.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double> animation})
      : greyPaint = Paint()
          ..color = Palette.lightGrey
          ..style = PaintingStyle.fill,
        darkGreyPaint = Paint()
          ..color = Palette.darkGrey
          ..style = PaintingStyle.fill,
        redPaint = Paint()
          ..color = Palette.red
          ..style = PaintingStyle.fill,
        liquidAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
            reverseCurve: Curves.easeInBack),
        redAnimation = CurvedAnimation(
            parent: animation,
            curve: Interval(
              0,
              0.7,
              curve: Interval(0, 0.8, curve: SpringCurve()),
            ),
            reverseCurve: Curves.linear),
        darkGreyAnimation = CurvedAnimation(
            parent: animation,
            curve: Interval(
              0,
              0.8,
              curve: Interval(0, 0.9, curve: SpringCurve()),
            ),
            reverseCurve: Curves.easeInCirc),
        greyAnimation = CurvedAnimation(
            parent: animation,
            curve: SpringCurve(),
            reverseCurve: Curves.easeInCirc),
        super(repaint: animation);

  final Animation<double> liquidAnimation;
  final Animation<double> greyAnimation;
  final Animation<double> darkGreyAnimation;
  final Animation<double> redAnimation;

  final Paint greyPaint;
  final Paint darkGreyPaint;
  final Paint redPaint;
  @override
  void paint(Canvas canvas, Size size) {
    paintGrey(canvas, size);
    paintDarkGrey(canvas, size);
    paintRed(canvas, size);
  }

  void paintGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, greyAnimation.value),
    );
    _addPointsToPath(path, [
      Point(
        lerpDouble(0, size.width / 3, greyAnimation.value),
        lerpDouble(0, size.height, greyAnimation.value),
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnimation.value),
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnimation.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnimation.value),
      ),
    ]);

    canvas.drawPath(path, greyPaint);
  }

  void paintDarkGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(size.height / 4, size.height / 2, darkGreyAnimation.value),
    );
    _addPointsToPath(path, [
      Point(
        size.width / 4,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnimation.value),
      ),
      Point(
        size.width * 3 / 5,
        lerpDouble(size.height / 4, size.height / 2, liquidAnimation.value),
      ),
      Point(
        size.width * 4 / 5,
        lerpDouble(size.height / 6, size.height / 3, darkGreyAnimation.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 5, size.height / 4, darkGreyAnimation.value),
      ),
    ]);

    canvas.drawPath(path, darkGreyPaint);
  }

  void paintRed(Canvas canvas, Size size) {
    if (redAnimation.value > 0) {
      final path = Path();
      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(0, size.height / 12, redAnimation.value),
      );
      _addPointsToPath(path, [
        Point(
          size.width /7 ,
          lerpDouble(0, size.height / 6, liquidAnimation.value),
        ),
        Point(
          size.width / 3,
          lerpDouble(0, size.height / 10, liquidAnimation.value),
        ),
        Point(
          size.width / 3 * 2,
          lerpDouble(0, size.height / 8, liquidAnimation.value),
        ),
        Point(
          size.width * 3 / 4,
          0,
        ),
      ]
      );
      canvas.drawPath(path, redPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError("Need three or more point to create a path");
    }
    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }
    // to connect last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}



class SpringCurve extends Curve {
  SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });

  final a;
  final w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
