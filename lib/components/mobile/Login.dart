import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/components/LoginForm.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';

class Login extends StatefulWidget {
  final API api;

  const Login({Key key, this.api}) : super(key: key);

  @override
  _LoginState createState() => _LoginState(api);
}

class _LoginState extends State<Login> {
  final API api;

  _LoginState(this.api);

  List<Widget> forms = [];
  bool login = true;

  toggler() {
    setState(() {
      login = !login;
    });
  }

  @override
  void initState() {
    super.initState();
    LoginForm loginForm = LoginForm(api: api, toggler: toggler);
    forms.add(loginForm.loginForm());
    forms.add(loginForm.registerForm());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Helpers.changeStatusBarColor(color: mSemiPrimary);

    return SingleChildScrollView(
      child: Container(
        color: mSemiPrimary,
        constraints: BoxConstraints(minHeight: height),
        child: Column(
          children: [
            SizedBox(
              height: height * .1,
            ),
            Image.asset("assets/img/msg/welcome.png", width: 100),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: CustomCard.decoration(),
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: forms[login ? 0 : 1])),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
