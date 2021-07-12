import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';

class Mobile extends StatelessWidget {
  final Widget child;

  Mobile(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      backgroundColor: Colors.white,
    );
  }
}
