import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';

class InputStyle {
  static const int card = 0;
  static const int grayed = 1;
}

class InputText extends StatelessWidget {
  final Widget textField;
  final double radius;
  final int style;

  static TextStyle hintStyle = TextStyle(color: Colors.black38);

  static InputDecoration inputDecoration({String hint}) {
    return InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: InputText.hintStyle);
  }

  InputText({this.textField, this.radius: 10, this.style: InputStyle.card});

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    BorderRadius rad = BorderRadius.all(Radius.circular(radius));

    switch (style) {
      case 0:
        decoration = CustomCard.decoration(radius: radius);
        break;
      case 1:
        decoration = BoxDecoration(
            color: Colors.black.withOpacity(.03), borderRadius: rad);
        break;
    }

    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: decoration,
        child: textField);
  }
}
