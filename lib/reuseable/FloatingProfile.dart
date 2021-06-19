import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Steps.dart';
import 'package:mentoring_id/reuseable/fancies/ProfilePicture.dart';
import 'package:mentoring_id/reuseable/fancies/circle.dart';
import 'package:mentoring_id/reuseable/fancies/circle_icon.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/SizedButton.dart';

import 'fancies/Paket.dart';
import 'fancies/XPbar.dart';

class FloatingProfile extends StatefulWidget {
  @override
  _FloatingProfileState createState() => _FloatingProfileState();
}

class _FloatingProfileState extends State<FloatingProfile> {
  double height = 230.0;
  final pressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: height * 0.4,
            width: 230.0,
            decoration: BoxDecoration(
                color: mTersierYellowColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(5, 5),
                      blurRadius: 8,
                      color: Colors.black.withOpacity(.04)),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, right: 6, left: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfilePicture(),
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
                              warna: mOrange,
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
                            CircleIcon(
                              tulisan: "A",
                              warna: mSecondaryRedColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '139',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFD49D3F),
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        XPbar()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 230,
            height: height * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedButton(
                  width: 70,
                  value: "EDIT",
                ),
                SizedBox(
                  width: 20,
                ),
                SizedButton(
                  width: 70,
                  value: "LOGOUT",
                  color: mTersierYellowColor,
                  textcolor: mOrange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
