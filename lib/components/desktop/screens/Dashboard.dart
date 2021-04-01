import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/TryoutList.dart';
import 'package:mentoring_id/reuseable/fancies/xp.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          TryoutList(),
         ]
      ),
    );
  }
}
