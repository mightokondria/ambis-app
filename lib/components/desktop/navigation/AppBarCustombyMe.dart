import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/reuseable/fancies/ProfileButton.dart';

import '../Desktop.dart';

class AppBarCustombyMe extends StatelessWidget implements PreferredSizeWidget {
  final double _prefferedHeight = 65.0;
  final API api;
  final DesktopState home;

  const AppBarCustombyMe({Key key, this.api, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _prefferedHeight,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
            ),
          ],
        ),
        //container dalam(seconder) untuk membungkus material di dalam kontainer primer
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Image.asset(
                  'assets/img/icons/ic/favicon.png',
                  width: 30.5,
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mentoring",
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Belajar online tanpa ribet",
                        style:
                            TextStyle(color: Color(0xFFcccccc), fontSize: 12)),
                  ],
                )
              ],
            ),
            ProfileButton(
              api: api,
              // toggler: () => home.widget.navigationBar.toggleProfile(),
            )
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}
