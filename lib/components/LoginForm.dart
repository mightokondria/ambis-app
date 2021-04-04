import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

// REUSABLE FOR DESKTOP AND MOBILE
class LoginForm {
  static String emailValidator(String v) {
    if (v.indexOf("@") < 0 || v.indexOf(".") < 0)
      return "Masukkan email dengan benar";

    return null;
  }

  static String passwordValidator(String val) {
    if (val.length < 8) return "Password harus terdiri minimal 8 karakter";

    return null;
  }

  static Widget togglerText(String text, Function toggler) {
    return GestureDetector(
      onTap: toggler,
      child: Text(
        "Belum punya akun?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: mHeadingText.withOpacity(.5),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Form loginForm(Function toggler) {
    return Form(
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
            SizedBox(height: 30),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                decoration: InputText.inputDecoration(hint: "Email"),
                validator: emailValidator,
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                decoration: InputText.inputDecoration(hint: "Password"),
                obscureText: true,
                validator: passwordValidator,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
                color: mPrimary,
                textColor: Colors.white,
                value: "masuk",
                onTap: () => print("I'M RELIEVED")),
            SizedBox(height: 20),
            togglerText("Belum punya akun?", toggler),
          ]),
    );
  }

  static Form registerForm(Function toggler) {
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
                registerKey.currentState.validate();
              },
            ),
            SizedBox(height: 20),
            togglerText("Sudah punya akun?", toggler),
          ]),
    );
  }
}
