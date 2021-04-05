import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/TryoutList.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(spacing: 10, runSpacing: 10, children: [
        TryoutList(
            {"nm_tryout": "mentoring 1", "xp": "43", "nm_akun": "mentoring"}),
      ]),
    );
  }
}
