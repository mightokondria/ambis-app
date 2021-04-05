import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/desktop/Login.dart';
import 'package:mentoring_id/components/desktop/navigation/AppBarCustombyMe.dart';
import 'package:mentoring_id/components/desktop/navigation/side_navigation_bar.dart';

class Desktop extends StatelessWidget {
  final API _api;

  Desktop(this._api);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> init = _api.initialState;
    bool isLoggedIn = true; //init["isLoggedIn"];
    bool noKelas = false; //init["tidakPunyaKelasLangganan"];

    return Scaffold(
      appBar: (isLoggedIn || !noKelas) ? AppBarCustombyMe() : null,
      body: isLoggedIn ? SideNavigationBar(api: _api) : Login(api: _api),
    );
  }
}
