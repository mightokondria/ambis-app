import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/LoginForm.dart';

class Login extends StatefulWidget {
  final API api;
  final bool login;

  const Login({Key key, this.api, this.login: true}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Widget> forms = [];
  bool login;

  toggler() {
    setState(() {
      login = !login;
    });
  }

  @override
  void initState() {
    super.initState();
    LoginForm loginForm = LoginForm(api: widget.api, toggler: toggler);
    forms.add(loginForm.loginForm());
    forms.add(loginForm.registerForm());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if (login == null) login = widget.login;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(minHeight: height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
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
        ),
      ),
    );
  }
}
