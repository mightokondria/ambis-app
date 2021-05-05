import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/InitialScreens.dart';
import 'package:mentoring_id/components/desktop/Desktop.dart';
import 'package:mentoring_id/components/desktop/Login.dart';
import 'package:mentoring_id/components/desktop/navigation/side_navigation_bar.dart';
import 'package:mentoring_id/components/mobile/Mobile.dart';

import 'Disconnected.dart';

class ScreenAdapter extends StatefulWidget {
  final API api;
  final double width;

  const ScreenAdapter({Key key, this.api, this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScreenAdapterState(api, width);
}

class ScreenAdapterState extends State<ScreenAdapter> {
  final API api;
  final int desktopResolution = 768;

  /*
  * INDEXES DETAIL
  * 0 : INITIAL HOMEPAGE
  * 1 : ERROR DISCONNECTED
  */
  int index = 0;
  double width;
  bool isDesktop;

  ScreenAdapterState(this.api, this.width);

  changeIndex(int i) => setState(() {
        index = i;
      });

  @override
  Widget build(BuildContext context) {
    isDesktop = width >= desktopResolution;

    api.parent = this;
    api.initHandlers();

    api.initialScreens = isDesktop
        ? InitialScreen(api,
            login: Login(
              api: api,
            ),
            home: SideNavigationBar(
              api: api,
            ))
        : InitialScreen(api);

    print("rebuilt");
    return IndexedStack(index: index, children: [
      isDesktop ? Desktop(api, api.getCurrentScreen()) : Mobile(api),
      Disconnected(
        api: api,
      ),
    ]);
  }
}
