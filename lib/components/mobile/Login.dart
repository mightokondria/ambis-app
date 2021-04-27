import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletion/DataCompletionPage.dart';
import 'package:mentoring_id/components/LoginForm.dart';

class Login extends StatefulWidget {
  final API api;

  const Login({Key key, this.api}) : super(key: key);

  @override
  _LoginState createState() => _LoginState(api);
}

class _LoginState extends State {
  final API api;

  _LoginState(this.api);

  List<Widget> forms = [];

  @override
  void initState() {
    super.initState();
    LoginForm loginForm = LoginForm(api: api);
    forms.add(loginForm.loginForm());
    forms.add(loginForm.registerForm());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(20),
          child: DataCompletionPage(api)),
    );
  }
}
