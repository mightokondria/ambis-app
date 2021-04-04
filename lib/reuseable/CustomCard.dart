import 'package:flutter/material.dart';

class CustomCard {

  static BoxDecoration decoration({Color color: Colors.white, double radius}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 5,
            color: Colors.black.withOpacity(.08)
          )
        ],
    );
  }

  static InputDecoration inputDecoration({Color color: Colors.white, double radius, InputBorder border: InputBorder.none}) {
    return InputDecoration(
      border: border,
    );
  }
}
