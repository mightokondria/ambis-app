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

class CustomButtonTab extends StatelessWidget {
  final Color inactiveColor, activeColor;
  final List<_CustomButtonTabButton> buttons;
  final Function(int) onChange;

  static _CustomButtonTabButton button(String value) =>
      _CustomButtonTabButton(value);

  CustomButtonTab(
      this.inactiveColor, this.activeColor, this.buttons, this.onChange);

  @override
  Widget build(BuildContext context) {
    return _CustomButtonTabElement(
      children: buttons,
      onChange: onChange,
      color: inactiveColor,
      activeColor: activeColor,
    );
  }
}

class _CustomButtonTabButton {
  final String value;

  _CustomButtonTabButton(this.value);
}

class _CustomButtonTabElement extends StatefulWidget {
  final List<_CustomButtonTabButton> children;
  final Color color, activeColor;
  final Function(int) onChange;

  const _CustomButtonTabElement(
      {Key key, this.color, this.activeColor, this.children, this.onChange})
      : super(key: key);

  @override
  __CustomButtonTabElementState createState() =>
      __CustomButtonTabElementState();
}

class __CustomButtonTabElementState extends State<_CustomButtonTabElement> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenWidget = [];

    widget.children.asMap().forEach((e, v) {
      childrenWidget.add(GestureDetector(
        onTap: () => setState(() {
          widget.onChange(e + 1);
          index = e;
        }),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: (index == e)
              ? widget.activeColor
              : widget.activeColor.withOpacity(.2),
          child: Text(v.value,
              style: TextStyle(
                  color: (index == e) ? widget.color : widget.activeColor)),
        ),
      ));
    });

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: childrenWidget,
      ),
    );
  }
}
