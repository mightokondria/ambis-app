import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/components/LoginForm.dart';
import 'package:mentoring_id/components/PaymentMethods.dart';
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
  MainAxisSize mainAxisSize;

  Dialogs({this.context, this.api}) {
    isDesktop = api.parent.isDesktop;
    mainAxisSize = isDesktop ? MainAxisSize.min : MainAxisSize.max;
  }

  Widget recoveryDialog(context) {
    TextEditingController emailController = TextEditingController();

    return Center(
      child: DialogElement(
        api: api,
        child: Form(
          key: recoveryFormKey,
          child: Column(
            mainAxisSize: mainAxisSize,
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

  Widget checkoutDialog(KelasLanggananModel data) {
    return Center(
      child: DialogElement(
        api: api,
        child: Form(
          child: Column(
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CHECKOUT",
                style: TextStyle(
                    color: mHeadingText,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Image.asset(
                        "assets/img/msg/checkout.png",
                        width: 70,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.nmAkun,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: mHeadingText,
                          ),
                        ),
                        Text(
                          data.waktuAktif + " bulan membership",
                          style: TextStyle(
                            color: mHeadingText.withOpacity(.3),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              PaymentMethods(
                api: api,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
