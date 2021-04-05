import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/fancies/circle.dart';
import 'package:mentoring_id/reuseable/fancies/xp.dart';

TextStyle description = TextStyle(
  color: Colors.black.withOpacity(.3),
  fontSize: 12,
);

class TryoutList extends StatefulWidget {
  final Map<String, String> data;

  TryoutList(this.data);

  @override
  _TryoutListState createState() => _TryoutListState(data);
}

class _TryoutListState extends State {
  bool clicked = false;
  final Map<String, String> data;

  _TryoutListState(this.data);

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
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              blurRadius: clicked? 1 : 8,
              offset: Offset(0, clicked? 0 : 3),
              color: Colors.black.withOpacity(clicked? .08 : .05),
            )
          ]
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            XPWidget("+" + data['xp']),
            SizedBox(height: 15),

            // NAMA/JUDUL TRYOUT
            Text(data['nm_tryout'].toUpperCase(), style: TextStyle(
              color: Colors.black.withOpacity(.5).withBlue(50).withGreen(20),
              fontWeight: FontWeight.w900,
              fontSize: 25,
            )),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // KELAS TRYOUT
                Text(data['nm_akun'].toUpperCase(), style: description,),
                // DESKRIPSI TRYOUT
                Text("100 soal 90 menit", style: description),
              ],
            ),
          ]
        )
      ),
    );
  }
}