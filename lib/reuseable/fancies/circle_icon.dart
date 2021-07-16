import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Color warna;
  final String tulisan;

  CircleIcon({this.warna, this.tulisan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: warna,
          onPressed: () {
            // Respond to button press
          },
          elevation: 0,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          hoverElevation: 0,
          autofocus: false,
          disabledElevation: 0,
          child: Text(
            tulisan,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
