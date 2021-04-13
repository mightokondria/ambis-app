import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/LoginForm.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/dialog/DialogElement.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

class Dialogs {
  final API api;
  final BuildContext context;

  // ALL FORM KEYS
  static final GlobalKey<FormState> recoveryFormKey = GlobalKey<FormState>();

  bool isDesktop = false;

  Dialogs({this.context, this.api}) {
    isDesktop = api.parent.isDesktop;
  }

  Widget recoveryDialog(context) {
    TextEditingController emailController = TextEditingController();

    return Center(
      child: DialogElement(
        api: api,
        child: Form(
          key: recoveryFormKey,
          child: Column(
            mainAxisSize: isDesktop ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Text(
                "Pemulihan password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mHeadingText,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                "Masukkan email akun yang ingin kamu pulihkan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mHeadingText.withOpacity(.4),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Material(
                child: InputText(
                  textField: TextFormField(
                    controller: emailController,
                    validator: LoginForm.emailValidator,
                    decoration: InputText.inputDecoration(hint: "Email"),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                value: "Pulihkan",
                color: mPrimary,
                textColor: Colors.white,
                onTap: () {
                  if (!recoveryFormKey.currentState.validate()) return null;

                  api.session.recovery(emailController).then((status) {
                    String message;

                    switch (status) {
                      case "recoveryLinkSent":
                        message = "Tautan pemulihan sudah dikirim ke emailmu.";
                        break;
                      case "emailNotRegisteredException":
                        message = "Email tidak terdaftar. Belum mendaftar?";
                        break;
                      default:
                        break;
                    }

                    if (status == "recoveryLinkSent") Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(message),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("TUTUP"))
                            ],
                          );
                        });
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomButton(
                  value: "Batal",
                  color: Colors.transparent,
                  textColor: mPrimary,
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
