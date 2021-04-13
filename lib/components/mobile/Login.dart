import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/LoginForm.dart';

class Login extends StatelessWidget {
  final API api;

  const Login({Key key, this.api}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginForm loginForm = LoginForm(api: api);

    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(20),
          child: loginForm.loginForm()),
    );
  }
}
