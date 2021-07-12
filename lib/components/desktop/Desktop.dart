import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/desktop/navigation/AppBarCustombyMe.dart';
import 'package:mentoring_id/components/desktop/navigation/side_navigation_bar.dart';

class Desktop extends StatefulWidget {
  final API _api;
  final Widget page;
  SideNavigationBarState navigationBar;

  Desktop(this._api, this.page);

  @override
  DesktopState createState() {
    _api.desktop = this;
    return DesktopState();
  }
}

class DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    final isHome = widget.page.runtimeType == SideNavigationBar;

    return Scaffold(
      appBar: (isHome) ? AppBarCustombyMe(api: widget._api, home: this) : null,
      body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500), child: widget.page),
    );
  }
}
