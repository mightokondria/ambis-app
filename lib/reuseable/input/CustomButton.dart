import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

import '../CustomCard.dart';
//
// class CustomButton extends StatefulWidget {
//   final String value;
//   final Widget child;
//   final Function onTap;
//   final double radius;
//   final Color color;
//   final Color textColor;
//   final bool fill;
//   final bool enabled;
//
//   CustomButton(
//       {this.value,
//       this.onTap,
//       this.radius: 5,
//       this.color: Colors.white,
//       this.textColor,
//       this.fill: true,
//       this.child,
//       this.enabled: true});
//
//   @override
//   State<StatefulWidget> createState() => _CustomButtonState(
//       value, onTap, radius, color, textColor, fill, child, enabled);
// }

class CustomButton extends StatelessWidget {
  bool pressed = false;

  final String value;
  final Function onTap;
  final double radius;
  final Color color;
  final Color textColor;
  final bool fill;
  final bool enabled;
  final Widget child;

  CustomButton(
      {this.value,
      this.onTap,
      this.radius: 10,
      this.color,
      this.textColor,
      this.fill: true,
      this.child,
      this.enabled: true});

  // void toggle() => setState(() {
  //       pressed = !pressed;
  //     });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTapDown: (TapDownDetails e) => toggle(),
        // onTapUp: (TapUpDetails e) => toggle(),
        onTap: enabled ? onTap : () {},
        child: Transform.scale(
          scale: pressed ? .99 : 1,
          child: Clickable(
            child: Container(
              width: fill ? double.infinity : null,
              decoration: (color != Colors.transparent)
                  ? CustomCard.decoration(
                      radius: radius,
                      color: enabled ? color : color.withOpacity(.4))
                  : null,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: (value != null)
                  ? Text(
                      value.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: (textColor == null) ? mHeadingText : textColor,
                      ),
                    )
                  : child,
            ),
          ),
        ));
  }
}
