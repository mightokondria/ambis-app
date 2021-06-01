import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';

class Mobile extends StatelessWidget {
  final API _api;
  final Widget child;

  Mobile(this._api, this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      backgroundColor: Colors.white,
    );
  }
}
