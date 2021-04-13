import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletionPage.dart';
import 'package:mentoring_id/components/desktop/Login.dart';
import 'package:mentoring_id/components/desktop/navigation/AppBarCustombyMe.dart';
import 'package:mentoring_id/components/desktop/navigation/side_navigation_bar.dart';

class Desktop extends StatelessWidget {
  final API _api;

  Desktop(this._api);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> init = _api.initialState;
    bool isLoggedIn = init["isLoggedIn"];
    bool noKelas = init["tidakPunyaKelasLangganan"];
    bool ready = init["ready"];

    return Scaffold(
      appBar: (isLoggedIn || !noKelas)
          ? ready
              ? AppBarCustombyMe()
              : null
          : null,
      body: isLoggedIn
          ? ready
              ? SideNavigationBar(api: _api)
              : DataCompletionPage(_api)
          : Login(api: _api),
    );
  }
}
