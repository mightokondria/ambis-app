import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/mobile/Login.dart';

class Mobile extends StatelessWidget {
  final API _api;

  Mobile(this._api);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Login(api: _api));
  }
}
