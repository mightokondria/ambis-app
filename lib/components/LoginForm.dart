import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

import 'LoadingAnimation.dart';

// REUSABLE FOR DESKTOP AND MOBILE
class LoginForm {
  final API api;
  final BuildContext context;
  final Function toggler;

  LoginForm({this.toggler, this.api, this.context});

  static String emailValidator(String v) {
    if (v.indexOf("@") < 0 || v.indexOf(".") < 0)
      return "Masukkan email dengan benar";

    return null;
  }

  static String passwordValidator(String val) {
    if (val.length < 8) return "Password harus terdiri minimal 8 karakter";

    return null;
  }

  Widget togglerText(String text) {
    return GestureDetector(
      onTap: toggler,
      child: Clickable(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mHeadingText.withOpacity(.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Form loginForm() {
    List<TextEditingController> controllers = [];
    final formKey = GlobalKey<FormState>();

    for (int i = 1; i <= 2; i++) {
      controllers.add(TextEditingController());
    }

    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Masuk",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: mHeadingText,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Masuk untuk melanjutkan",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 10),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                decoration: InputText.inputDecoration(hint: "Email"),
                validator: emailValidator,
                controller: controllers[0],
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                decoration: InputText.inputDecoration(hint: "Password"),
                obscureText: true,
                validator: passwordValidator,
                controller: controllers[1],
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  api.ui.showRecoveryDialog();
                },
                child: Clickable(
                  child: Text(
                    "Lupa password?",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: mHeadingText.withOpacity(.5),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
                color: mPrimary,
                textColor: Colors.white,
                value: "masuk",
                onTap: () {
                  if (formKey.currentState.validate())
                    api.session.masuk(controllers).then((value) {
                      if (!value)
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Email atau password tidak tersedia.")));
                      else
                        api.session.save();
                    });
                }),
            SizedBox(height: 20),
            togglerText("Belum punya akun?"),
          ]),
    );
  }

  Form registerForm() {
    final registerKey = GlobalKey<FormState>();
    final List<TextEditingController> controllers = [];

    for (int i = 1; i <= 4; i++) {
      controllers.add(TextEditingController());
    }

    return Form(
      key: registerKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Daftar",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: mHeadingText,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Daftar menggunakan email",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 30),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                controller: controllers[0],
                decoration: InputText.inputDecoration(hint: "Nama"),
                validator: (String val) {
                  if (val.length < 5) return "Masukkan nama dengan benar";

                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                controller: controllers[1],
                decoration: InputText.inputDecoration(hint: "Email"),
                validator: emailValidator,
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                controller: controllers[2],
                obscureText: true,
                decoration: InputText.inputDecoration(hint: "Password"),
                validator: passwordValidator,
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                controller: controllers[3],
                obscureText: true,
                decoration: InputText.inputDecoration(hint: "Ulangi password"),
                validator: (String val) {
                  if (val != controllers[2].value.text)
                    return "Password tidak cocok";

                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              color: mPrimary,
              textColor: Colors.white,
              value: "daftar",
              onTap: () {
                //if (registerKey.currentState.validate()) api.loadingAnimation();
              },
            ),
            SizedBox(height: 20),
            togglerText("Sudah punya akun?"),
          ]),
    );
  }
}
