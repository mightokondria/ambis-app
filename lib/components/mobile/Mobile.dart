import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletion/DataCompletionPage.dart';

class Mobile extends StatelessWidget {
  final API _api;

  Mobile(this._api);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> init = _api.initialState;
    bool isLoggedIn = init["isLoggedIn"];
    bool noKelas = init["tidakPunyaKelasLangganan"];

    return DataCompletionPage(_api);
  }
}
