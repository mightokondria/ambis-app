import 'package:flutter/material.dart';

class MicroIdentityForLists extends StatelessWidget {
  final Color backgroundColor, textColor;
  final Widget icon;
  final String value;

  const MicroIdentityForLists(
      {Key key,
      this.backgroundColor: Colors.transparent,
      this.textColor: const Color(0xFF555555),
      @required this.icon,
      @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(children: [
              icon,
              SizedBox(width: 10),
              Text(value,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12))
            ]))
      ],
    );
  }
}
