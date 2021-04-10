import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/desktop/screens/Dashboard.dart';
import 'package:mentoring_id/components/desktop/screens/Tryout.dart';
import 'package:mentoring_id/components/desktop/screens/Update.dart';
import 'package:mentoring_id/components/desktop/screens/bedah_jurusan.dart';
import 'package:mentoring_id/components/desktop/screens/feedback.dart';
import 'package:mentoring_id/components/desktop/screens/histori_tryout.dart';
import 'package:mentoring_id/components/desktop/screens/pengaturan.dart';
import 'package:mentoring_id/components/desktop/screens/rangkuman.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/sidebar-navigation/DesktopSidebar.dart';

class SideNavigationBar extends StatefulWidget {
  final API api;

  const SideNavigationBar({Key key, this.api}) : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState(api);
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  int selectedIndex = 2;
  int navIndex = 0;

  final API _api;

  _SideNavigationBarState(this._api);

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    ScrollController sidebarNavigationScroll = ScrollController();

    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            child: Container(
              height: _height,
              width: 300,
              child: Scrollbar(
                isAlwaysShown: true,
                controller: sidebarNavigationScroll,
                child: SingleChildScrollView(
                  controller: sidebarNavigationScroll,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25, top: 25),
                        child: Text(
                          "Explore",
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      DesktopSidebar(selectedIndex, changeIndex),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
              color: mGreyColor,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  height: _height,
                  margin:
                      EdgeInsets.only(left: 30, right: _width - (_width * .95)),
                  child: Builder(builder: (context) {
                    //DASHBOARD == 0
                    if (selectedIndex == 0) {
                      return Dashboard();
                    }
                    //UPDATE == 1
                    if (selectedIndex == 1) {
                      return Update();
                    }
                    //TRYOUT == 2
                    if (selectedIndex == 2) {
                      return Tryout();
                    }
                    //HISTORI TRYOUT == 3
                    if (selectedIndex == 3) {
                      return HistoriTryout();
                    }
                    //RANGKUMAN == 4
                    if (selectedIndex == 4) {
                      return Rangkuman();
                    }
                    //BEDAH JURUSAN == 5
                    if (selectedIndex == 5) {
                      return BedahJurusan();
                    }
                    //PENGATURAN
                    if (selectedIndex == 6) {
                      return Pengaturan();
                    }
                    //FeedBack
                    if (selectedIndex == 7) {
                      return FeedBack();
                    }

                    return Container();
                  }),
                ),
              )),
        )
      ],
    );
  }
}
