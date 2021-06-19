import 'package:flutter/material.dart';

class CustomCard {
  static BoxDecoration decoration(
      {Color color: Colors.white, double radius: 10, bool shadow: true}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      boxShadow: shadow
          ? [
              BoxShadow(
                  offset: Offset(5, 5),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(.04))
            ]
          : [],
    );
  }

  static InputDecoration inputDecoration(
      {Color color: Colors.white,
      double radius,
      InputBorder border: InputBorder.none}) {
    return InputDecoration(
      border: border,
    );
  }
}
