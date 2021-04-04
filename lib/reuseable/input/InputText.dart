import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';

class InputText extends StatelessWidget {

  final Widget textField;
  final double radius;

  static InputDecoration defaultStyle({String hint}) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.black38
      )
    );
  }

  InputText({this.textField, this.radius: 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: CustomCard.decoration(radius: radius),
      child: textField
    );
  }
}