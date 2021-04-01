import 'package:ambis_app/reuseable/Search_bar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: SearchBar(),
    );
  }
}
