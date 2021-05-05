import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletion/DataCompletionPage.dart';
import 'package:mentoring_id/components/desktop/Login.dart';
import 'package:mentoring_id/components/desktop/navigation/AppBarCustombyMe.dart';
import 'package:mentoring_id/components/desktop/navigation/side_navigation_bar.dart';

class Desktop extends StatelessWidget {
  final API _api;
  final Widget page;

  Desktop(this._api, this.page);

  @override
  Widget build(BuildContext context) {
    bool isHome = page.runtimeType == SideNavigationBar;

    return Scaffold(
      appBar: (isHome) ? AppBarCustombyMe() : null,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: page,
      ),
    );
  }
}
