import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';

import '../CustomCard.dart';

class CustomButton extends StatefulWidget {
  final String value;
  final Function onTap;
  final double radius;
  final Color color;
  final Color textColor;
  final bool fill;

  CustomButton(
      {this.value,
      this.onTap,
      this.radius: 5,
      this.color: Colors.white,
      this.textColor,
      this.fill: true});

  @override
  State<StatefulWidget> createState() =>
      _CustomButtonState(value, onTap, radius, color, textColor, fill);
}

class _CustomButtonState extends State<CustomButton> {
  bool pressed = false;

  final String value;
  final Function onTap;
  final double radius;
  final Color color;
  final Color textColor;
  final bool fill;

  _CustomButtonState(this.value, this.onTap, this.radius, this.color,
      this.textColor, this.fill);

  void toggle() => setState(() {
        pressed = !pressed;
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (TapDownDetails e) => toggle(),
        onTapUp: (TapUpDetails e) => toggle(),
        onTap: onTap,
        child: Transform.scale(
          scale: pressed ? .99 : 1,
          child: Container(
            width: double.infinity,
            decoration: (color != Colors.transparent)
                ? CustomCard.decoration(radius: radius, color: color)
                : null,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              value.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: (textColor == null) ? mHeadingText : textColor,
              ),
            ),
          ),
        ));
  }
}
