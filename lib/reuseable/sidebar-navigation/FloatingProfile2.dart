import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Steps.dart';
import 'package:mentoring_id/reuseable/fancies/Paket.dart';
import 'package:mentoring_id/reuseable/fancies/ProfilePicture.dart';
import 'package:mentoring_id/reuseable/fancies/XPbar.dart';
import 'package:mentoring_id/reuseable/fancies/circle.dart';
import 'package:mentoring_id/reuseable/fancies/circle_icon.dart';

class FloatingProfile2 extends StatefulWidget {
  @override
  _FloatingProfile2State createState() => _FloatingProfile2State();
}

class _FloatingProfile2State extends State<FloatingProfile2> {
  double height = 230.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: height,
            width: 230.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(5, 5),
                      blurRadius: 8,
                      color: Colors.black.withOpacity(.04)),
                ]),
          ),
          Container(
            height: height * 0.4,
            width: 230.0,
            decoration: BoxDecoration(
                color: mTersierYellowColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
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
          Positioned(
            top: height * 0.4,
            child: Container(
              width: 230,
              color: Colors.green,
              child: Wrap(spacing: 12, children: [
                Paket(
                  tulisan: "kuvux",
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
