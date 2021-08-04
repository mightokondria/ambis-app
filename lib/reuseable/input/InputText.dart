import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';

import 'CustomButton.dart';

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

class PasswordFormField extends StatefulWidget {
  final bool seek;
  final TextEditingController controller;
  final void Function(String) validator;
  final String hint;
  final int style;

  const PasswordFormField(
      {Key key,
      this.seek: true,
      this.controller,
      this.validator,
      this.hint,
      this.style: InputStyle.card})
      : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscure = true;

  switchObscure() => setState(() {
        obscure = !obscure;
      });

  @override
  Widget build(BuildContext context) {
    Widget seek = SizedBox();

    if (widget.seek)
      seek = CustomButton(
          padding: EdgeInsets.zero,
          style: CustomButtonStyle.transparent(),
          fill: false,
          onTap: switchObscure,
          child: Icon(obscure ? Icons.visibility : Icons.visibility_off_rounded,
              color: Colors.black45));

    return InputText(
      style: InputStyle.grayed,
      textField: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: obscure,
              validator: widget.validator,
              decoration: InputText.inputDecoration(hint: widget.hint),
            ),
          ),
          SizedBox(width: 5),
          seek,
        ],
      ),
    );
  }
}
