import 'package:mentoring_id/reuseable/SearchBar.dart';
import 'package:flutter/material.dart';

class Tryout extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Tryout> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: SearchBar(),
    );
  }
}
