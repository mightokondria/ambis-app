import 'package:flutter/material.dart';
import 'package:mentoring_id/components/LoginForm.dart';
import 'package:mentoring_id/constants/color_const.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool login = true;

  toggle() => setState(() {
        login = !login;
      });

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
              flex: 2,
              child: Container(
                  color: mSemiPrimary.withOpacity(.5),
                  child: Center(
                      child: Image.asset(
                    "assets/img/msg/tryout.png",
                    width: 200,
                  )))),
          Flexible(
              flex: 1,
              child: Scrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(50),
                    child: Center(
                        child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: login
                          ? LoginForm.loginForm(toggle)
                          : LoginForm.registerForm(toggle),
                    )),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
