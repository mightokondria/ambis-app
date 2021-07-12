import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class Disconnected extends StatelessWidget {
  final API api;

  const Disconnected({Key key, this.api}) : super(key: key);

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
              child: Column(
                children: [
                  Text(
                    "Oops! Terjadi kesalahan jaringan atau server. Coba ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: mHeadingText.withOpacity(.3)),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                      style: CustomButtonStyle.primary(radius: 5),
                      value: "reload",
                      onTap: api.refresh),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
