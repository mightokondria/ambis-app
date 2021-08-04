import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class PreLogin extends StatelessWidget {
  final API api;

  const PreLogin({Key key, this.api}) : super(key: key);

  open(BuildContext context, {login: true}) => Navigator.of(context)
      .pushNamed("/login", arguments: Args(api: api, data: login));

  @override
  Widget build(BuildContext context) {
    final radius = 3.0;
    final padding = EdgeInsets.all(18);

    Helpers.changeStatusBarColor(color: Colors.white);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/img/msg/welcome.png", width: 100),
                    SizedBox(height: 30),
                    Text(
                      "Halo!",
                      style: TextStyle(
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Halo, Sobat Mentoringg.id! Untuk melanjutkan, yuk login atau buat akun baru!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF888888)),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(height: 40),
            Column(children: [
              CustomButton(
                value: "masuk",
                // fill: false,
                padding: padding,
                style: CustomButtonStyle.primary(radius: radius, shadow: false),
                onTap: () => open(context),
              ),
              SizedBox(height: 10),
              CustomButton(
                value: "daftar",
                padding: padding,
                style: CustomButtonStyle.semiPrimary(
                    radius: radius, shadow: false),
                onTap: () => open(context, login: false),
                // fill: false,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
