import 'package:flutter/material.dart';

Widget circleShape({double radius, Color color, Widget child}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    padding: EdgeInsets.all(radius),
    child: child,
  );
}