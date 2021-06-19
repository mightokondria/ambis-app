import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';

class Paket extends StatelessWidget {
  final String tulisan;

  Paket({this.tulisan});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 60,
          height: 20,
          decoration: BoxDecoration(
              color: mPink,
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              tulisan,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10, fontFamily: "Open Sans", color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
