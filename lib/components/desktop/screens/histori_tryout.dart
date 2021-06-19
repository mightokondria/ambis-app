import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/FloatingProfile.dart';
import 'package:mentoring_id/reuseable/sidebar-navigation/FloatingProfile2.dart';

class HistoriTryout extends StatefulWidget {
  @override
  _HistoriTryoutState createState() => _HistoriTryoutState();
}

class _HistoriTryoutState extends State<HistoriTryout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(margin: EdgeInsets.all(12), child: FloatingProfile()),
      ],
    );
  }
}
