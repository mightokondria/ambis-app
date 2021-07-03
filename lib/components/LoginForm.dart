import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

// REUSABLE FOR DESKTOP AND MOBILE
class LoginForm {
  final API api;
  final BuildContext context;
  final Function toggler;

  LoginForm({this.toggler, this.api, this.context});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  static String emailValidator(String v) {
    if (v.indexOf("@") < 0 || v.indexOf(".") < 0)
      return "Masukkan email dengan benar";

    return null;
  }

  static String passwordValidator(String val) {
    if (val.length < 8) return "Password harus terdiri minimal 8 karakter";

    return null;
  }

  static List<TextEditingController> loginControllers =
      Helpers.generateEditingControllers(2);
  static List<TextEditingController> registerControllers =
      Helpers.generateEditingControllers(4);

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
    return Form(
      key: loginFormKey,
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
            SizedBox(height: 50),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                decoration: InputText.inputDecoration(hint: "Email"),
                validator: emailValidator,
                controller: loginControllers[0],
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                decoration: InputText.inputDecoration(hint: "Password"),
                obscureText: true,
                validator: passwordValidator,
                controller: loginControllers[1],
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
                value: "masuk",
                onTap: () {
                  if (loginFormKey.currentState.validate())
                    api.session.masuk(loginControllers).then((value) {
                      if (!value)
                        api.showSnackbar(
                            content:
                                Text("Email atau password tidak tersedia."));
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
    return Form(
      key: registerFormKey,
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
                controller: registerControllers[0],
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
                controller: registerControllers[1],
                decoration: InputText.inputDecoration(hint: "Email"),
                validator: emailValidator,
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                controller: registerControllers[2],
                obscureText: true,
                decoration: InputText.inputDecoration(hint: "Password"),
                validator: passwordValidator,
              ),
            ),
            SizedBox(height: 20),
            InputText(
              style: InputStyle.grayed,
              textField: TextFormField(
                controller: registerControllers[3],
                obscureText: true,
                decoration: InputText.inputDecoration(hint: "Ulangi password"),
                validator: (String val) {
                  if (val != registerControllers[2].value.text)
                    return "Password tidak cocok";

                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              value: "daftar",
              onTap: () {
                if (registerFormKey.currentState.validate())
                  api.session.register(registerControllers);
              },
            ),
            SizedBox(height: 20),
            togglerText("Sudah punya akun?"),
          ]),
    );
  }
}
