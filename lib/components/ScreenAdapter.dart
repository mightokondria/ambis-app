import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletion/DataCompletionPage.dart';
import 'package:mentoring_id/components/InitialScreens.dart';
import 'package:mentoring_id/components/desktop/Desktop.dart';
import 'package:mentoring_id/components/desktop/Login.dart';
import 'package:mentoring_id/components/desktop/PendingInvoice.dart';
import 'package:mentoring_id/components/desktop/navigation/side_navigation_bar.dart';
import 'package:mentoring_id/components/mobile/Login.dart' as MobileLogin;
import 'package:mentoring_id/components/mobile/PendingInvoice.dart'
    as MobileInvoice;
import 'package:mentoring_id/components/mobile/Mobile.dart';

import 'Disconnected.dart';
import 'mobile/Home.dart';

class ScreenAdapter extends StatefulWidget {
  final API api;
  final double width;

  const ScreenAdapter({Key key, this.api, this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScreenAdapterState(api, width);
}

class ScreenAdapterState extends State<ScreenAdapter> {
  final API api;
  final int desktopResolution = 1024;

  /*
  * INDEXES DETAIL
  * 0 : INITIAL HOMEPAGE
  * 1 : ERROR DISCONNECTED
  */
  int index = 0;
  double width;
  bool isDesktop;

  ScreenAdapterState(this.api, this.width);

  update() => setState(() {});

  changeIndex(int i) => setState(() {
        index = i;
      });

  @override
  void initState() {
    super.initState();

    isDesktop = width >= desktopResolution;
    api.initScreenAdapter(
        this,
        isDesktop
            ? InitialScreen(api,
                login: Login(
                  api: api,
                ),
                home: SideNavigationBar(
                  api: api,
                ),
                pendingInvoice: PendingInvoice(
                  api: api,
                ),
                dataCompletion: DataCompletionPage(api))
            : InitialScreen(api,
                login: MobileLogin.Login(api: api),
                home: Home(api),
                pendingInvoice: MobileInvoice.PendingInvoice(
                  api: api,
                ),
                dataCompletion: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DataCompletionPage(api),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: index, children: [
      isDesktop
          ? Desktop(api, api.getCurrentScreen())
          : Mobile(api.getCurrentScreen()),
      Disconnected(
        api: api,
      ),
    ]);
  }
}
