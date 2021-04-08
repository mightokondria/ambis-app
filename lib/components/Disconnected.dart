import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';

class Disconnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/msg/terputus.png",
              width: 180,
            ),
            SizedBox(height: 30),
            Text(
              "Terputus",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: mHeadingText),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 200,
              child: Text(
                "Terjadi kesalahan jaringan atau server",
                textAlign: TextAlign.center,
                style: TextStyle(color: mHeadingText.withOpacity(.3)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
