import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/fancies/circle_icon.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class FloatingProfile extends StatefulWidget {
  @override
  _FloatingProfileState createState() => _FloatingProfileState();
}

class _FloatingProfileState extends State<FloatingProfile> {
  double height = 230.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 230, maxWidth: 300),
      decoration: CustomCard.decoration(),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/img/icons/profile.png",
                width: 50,
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Muhammad Arifin Ilham',
                          style: TextStyle(
                              color: Color(0xFFD49D3F),
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleIcon(
                            tulisan: "XP",
                            warna: mPrimary,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '360',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFFD49D3F),
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Expanded(
                child: CustomButton(
                    value: "pengaturan",
                    style: CustomButtonStyle.primary(radius: 5),
                    fill: false)),
            SizedBox(width: 5),
            Expanded(
                child: CustomButton(
                    value: "logout",
                    style: CustomButtonStyle.semiPrimary(radius: 5),
                    fill: false)),
          ])
        ],
      ),
    );
  }
}
