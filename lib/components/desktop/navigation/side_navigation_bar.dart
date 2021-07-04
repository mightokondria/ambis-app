import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/desktop/screens/Dashboard.dart';
import 'package:mentoring_id/components/desktop/screens/Tryout.dart';
import 'package:mentoring_id/components/desktop/screens/Update.dart';
import 'package:mentoring_id/components/desktop/screens/bedah_jurusan.dart';
import 'package:mentoring_id/components/desktop/screens/feedback.dart';
import 'package:mentoring_id/components/desktop/screens/pengaturan.dart';
import 'package:mentoring_id/components/desktop/screens/rangkuman.dart';
import 'package:mentoring_id/components/features/HistoryTryout.dart';
import 'package:mentoring_id/reuseable/sidebar-navigation/DesktopSidebar.dart';

class SideNavigationBar extends StatefulWidget {
  final API api;

  const SideNavigationBar({Key key, this.api}) : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState(api);
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  int selectedIndex = 3;
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
    final Size size = MediaQuery.of(context).size;
    final double _width = size.width;
    final ScrollController contentScrollController = ScrollController();

    return Scrollbar(
      isAlwaysShown: true,
      controller: contentScrollController,
      child: SingleChildScrollView(
        controller: contentScrollController,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: 300,
                margin: EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "Explore",
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    DesktopSidebar(selectedIndex, changeIndex),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
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
                      return TryoutDataScreen(
                        api: _api,
                      );
                    }
                    //HISTORI TRYOUT == 3
                    if (selectedIndex == 3) {
                      return HistoryTryout.desktop(Args(
                          api: widget.api, data: widget.api.nilai.historia));
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
        ),
      ),
    );
  }
}
