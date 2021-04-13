import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/mobile/Login.dart';

class Mobile extends StatelessWidget {
  final API _api;

  Mobile(this._api);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> init = _api.initialState;
    bool isLoggedIn = init["isLoggedIn"];
    bool noKelas = init["tidakPunyaKelasLangganan"];

    return Login(
      api: _api,
    );
  }
}
