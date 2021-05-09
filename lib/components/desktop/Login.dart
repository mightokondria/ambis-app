import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
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
  bool login = true;

  final API api;

  _LoginState(this.api);

  toggle() => setState(() {
        login = !login;
      });

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    LoginForm forms = LoginForm(api: api, context: context, toggler: toggle);

    // return Container(
    //   child: Row(
    //     children: [
    //       Flexible(
    //           flex: 2,
    //           child: Container(
    //               color: Colors.green,
    //               child: Center(
    //                   child: Image.asset(
    //                 "assets/img/msg/tryout-icon.png",
    //                 width: 200,
    //               )))),
    //       Flexible(
    //           flex: 3,
    //           child: Scrollbar(
    //             isAlwaysShown: true,
    //             controller: scrollController,
    //             child: SingleChildScrollView(
    //               controller: scrollController,
    //               child: Container(
    //                 padding: EdgeInsets.all(50),
    //                 child: Center(
    //                     child: AnimatedSwitcher(
    //                   transitionBuilder: (child, animation) {
    //                     final slide = Tween<Offset>(
    //                             begin: Offset(0, 0.5), end: Offset(0, 0))
    //                         .animate(animation);

    //                     return FadeTransition(
    //                         opacity: animation,
    //                         child:
    //                             SlideTransition(position: slide, child: child));
    //                   },
    //                   duration: Duration(milliseconds: 500),
    //                   child: login ? forms.loginForm() : forms.registerForm(),
    //                 )),
    //               ),
    //             ),
    //           ))
    //     ],
    //   ),
    // );
    //
    return Container(
        decoration: BoxDecoration(
          color: mSemiPrimary,
          // image: DecorationImage(
          //     image: AssetImage("assets/img/logomentoring.png"),
          //     repeat: ImageRepeat.repeat)
        ),
        child: Center(
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: api.screenAdapter.width / 3),
                decoration: CustomCard.decoration(),
                padding: EdgeInsets.all(40),
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: login ? forms.loginForm() : forms.registerForm()))));
  }
}
