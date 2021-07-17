import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

import '../../DashboardElements.dart';

class Dashboard extends StatefulWidget {
  final API api;

  const Dashboard({Key key, this.api}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final features = ["History tryout", "Rangkuman", "Bedah jurusan", "Progress"];
  List<Function> onTaps = [];
  bool triedCaching = false;

  @override
  Widget build(BuildContext context) {
    Helpers.changeStatusBarColor(color: Colors.white);

    onTaps = [
      widget.api.nilai.getHistory,
      widget.api.rangkuman.getRangkumanList,
      widget.api.bejur.openBejur,
      () => null,
    ];

    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MobileDashboardProfile(
                      api: widget.api,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        icon(0),
                        icon(1),
                        icon(2),
                        icon(3),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GroupInvitations(api: widget.api),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IkhtisarNilai(api: widget.api),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TryoutRecommendation(api: widget.api),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget icon(int i) {
    return Expanded(
      child: CustomButton(
        style: CustomButtonStyle.transparent(),
        onTap: onTaps[i],
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Image.asset(
                "assets/img/navigation/" +
                    features[i].split(" ").join("-").toLowerCase() +
                    "-on.png",
                width: 35,
                height: 35,
              ),
            ),
            SizedBox(height: 15),
            Text(features[i],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF555555),
                )),
          ],
        ),
      ),
    );
  }
}
