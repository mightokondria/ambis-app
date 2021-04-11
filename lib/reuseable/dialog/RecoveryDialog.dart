import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

class RecoveryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          decoration: CustomCard.decoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Pemulihan password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mHeadingText,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                "Masukkan email akun yang ingin kamu pulihkan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mHeadingText.withOpacity(.4),
                  fontSize: 14,
                  decoration: TextDecoration.none
                ),
              ),
              SizedBox(height: 10),
              Material(child: InputText(textField: TextField(),)),
            ],
          ),
        ),
      );
}
