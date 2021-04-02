import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/fancies/circle.dart';

class XPWidget extends StatelessWidget {

  final String xp;

  XPWidget(this.xp);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        circleShape(
          color: Colors.orangeAccent, 
          radius: 6, 
          child: Center(
            child: Text("XP", style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        )),
        SizedBox(width: 10),
        Text(xp, style: TextStyle(color: Color(0xd6a569).withOpacity(1), fontWeight: FontWeight.bold)),
      ],
    );
  }
}