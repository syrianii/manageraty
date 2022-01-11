import 'package:flutter/material.dart';
import 'package:user_managment/config/palette.dart';
import 'package:user_managment/config/point.dart';

class HomeBackGroundPainter extends CustomPainter {
  HomeBackGroundPainter()
      : greyPaint = Paint()
          ..color = Palette.lightGrey
          ..style = PaintingStyle.fill,
        darkGreyPaint = Paint()
          ..color = Palette.darkGrey
          ..style = PaintingStyle.fill,
        redPaint = Paint()
          ..color = Palette.red
          ..style = PaintingStyle.fill;
  final Paint greyPaint;
  final Paint darkGreyPaint;
  final Paint redPaint;
  @override
  void paint(Canvas canvas, Size size) {
    paintRed(canvas, size);
    paintGrey(canvas, size);
    paintDarkGrey(canvas, size);
  }

  void paintRed(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 1.1/5, size.height * 2.2 / 3);

    path.lineTo(size.width * 0.3, size.height) ;
    path.lineTo(0, size.height);

    _addPointsToPath(path, [
      Point(size.width * 1/5,size.height * 2/3),
      Point(size.width * 2/ 5, size.height * 4/5),
      Point(size.width * 0.3,size.height),

    ]);
    canvas.drawPath(path, redPaint);
  }
  void paintDarkGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 2.3 / 3);

    path.lineTo(size.width * 0.5, size.height) ;
    path.lineTo(0, size.height);

     _addPointsToPath(path, [
       Point(0,size.height * 2/3),
      Point(size.width * 1/ 5, size.height * 4/5),
    Point(size.width * 0.5,size.height),

     ]);
    canvas.drawPath(path, darkGreyPaint);
  }


  void paintGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height * 2 / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    _addPointsToPath(path, [
      Point(size.width / 2, size.height * 2.4 / 3),
      Point(size.width / 2, size.height * 1.7 / 3),
      Point(size.width, size.height * 2.2 / 3),
    ]);
    canvas.drawPath(path, greyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError("Need three or more points to create a path");
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
