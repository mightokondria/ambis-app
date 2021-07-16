import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class SizedButton extends StatefulWidget {
  final String value;
  final Color color;
  final Color textcolor;
  final double width, height;

  SizedButton({
    this.value: "YNTKTS",
    this.color: mOrange,
    this.textcolor: Colors.white,
    this.height: 30,
    this.width: 60,
  });

  @override
  _SizedButtonState createState() => _SizedButtonState();
}

class _SizedButtonState extends State<SizedButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Transform.scale(
        scale: pressed ? .80 : 1,
        child: Clickable(
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: widget.color),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: widget.textcolor),
                )),
          ),
        ),
      ),
    );
  }
}
