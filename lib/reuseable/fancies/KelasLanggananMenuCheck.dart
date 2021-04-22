import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';

class KelasLanggananMenuCheck extends CustomPainter {
  final Color color;

  KelasLanggananMenuCheck({this.color: mPrimary});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color;
    double width = size.width;
    double height = size.height;

    Path path = Path()
      ..moveTo(width * .1, height * .55)
      ..lineTo(width * .4, height)
      ..lineTo(width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
