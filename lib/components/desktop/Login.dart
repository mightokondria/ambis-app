import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

class Login extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Container(
            )
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: mSemiPrimary,
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  InputText(
                    textField: TextFormField(
                      decoration: InputText.defaultStyle(hint: "Email"),
                    ),
                  ),

                  SizedBox(height: 30),

                  InputText(
                    textField: TextFormField(
                      decoration: InputText.defaultStyle(hint: "Email"),
                    ),
                  ),

                  SizedBox(height: 30),
                  
                  Container(
                    decoration: CustomCard.decoration(),
                    padding: EdgeInsets.all(20),
                  )
                ]
              ),
            )
          )
        ],
      ),
    );
  }
}
