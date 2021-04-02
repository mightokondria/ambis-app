import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/fancies/circle.dart';
import 'package:mentoring_id/reuseable/fancies/xp.dart';

TextStyle description = TextStyle(
  color: Colors.black.withOpacity(.3),
  fontSize: 12,
);

class TryoutList extends StatefulWidget {
  @override
  _TryoutListState createState() => _TryoutListState();
}

class _TryoutListState extends State {
  bool clicked = false;

  void toggle() {
    setState(() {
      clicked = !clicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails e) { toggle(); },
      onTapUp: (TapUpDetails e) { toggle(); },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 160,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              blurRadius: clicked? 5 : 8,
              offset: Offset(0, 3),
              color: Colors.black.withOpacity(clicked? .1 : .05),
            )
          ]
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              top: 20,
              child: XPWidget("+69"),
            ),
            SizedBox(height: 15),
            // TODO SIMPLIFY THIS TO REUSEABLE COMPONENT
            Text("MENTORING 1", style: TextStyle(
              color: Colors.black.withOpacity(.5).withBlue(50).withGreen(20),
              fontWeight: FontWeight.w900,
              fontSize: 25,
            )),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("SBMPTN", style: description,),
                Text("100 soal 90 menit", style: description),
              ],
            ),
          ]
        )
      ),
    );
  }
}