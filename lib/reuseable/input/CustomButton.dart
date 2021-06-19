import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

import '../CustomCard.dart';

class CustomButton extends StatelessWidget {
  final String value;
  final Function onTap;
  final bool fill;
  final bool enabled;
  final Widget child;
  CustomButtonStyle style;

  CustomButton(
      {this.value,
      this.fill: true,
      this.child,
      this.enabled: true,
      this.onTap,
      this.style}) {
    style = (style == null) ? CustomButtonStyle.primary() : style;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: enabled ? onTap : () {},
        child: Transform.scale(
          scale: 1,
          child: Clickable(
            child: Container(
              width: fill ? double.infinity : null,
              decoration: (style.color != Colors.transparent)
                  ? CustomCard.decoration(
                      radius: style.radius,
                      shadow: style.shadow,
                      color:
                          enabled ? style.color : style.color.withOpacity(.4))
                  : null,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: (value != null)
                  ? Text(
                      value.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: (style.textColor == null)
                            ? mHeadingText
                            : style.textColor,
                      ),
                    )
                  : child,
            ),
          ),
        ));
  }
}

class CustomButtonStyle {
  Color color = mPrimary, textColor = Colors.white;

  final double radius;
  final bool shadow;

  CustomButtonStyle.primary({this.radius: 10, this.shadow: true});
  CustomButtonStyle.semiPrimary({this.radius: 10, this.shadow: true}) {
    color = mSemiPrimary;
    textColor = mPrimary;
  }
  CustomButtonStyle.accent({this.radius: 10, this.shadow: true}) {
    color = Colors.blue;
  }
  CustomButtonStyle.transparent(
      {this.radius: 10, this.shadow: true, this.textColor: mPrimary}) {
    color = Colors.transparent;
  }

  CustomButtonStyle(
      {this.color, this.textColor, this.radius: 10, this.shadow: true});
}

abstract class DialogButtonsGroupItems {
  // String value = CustomButtonStyle.primary();
  Widget child;
  bool shadow;
}

class DialogButtonGroup {}
