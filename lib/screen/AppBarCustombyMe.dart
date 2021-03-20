import 'package:flutter/material.dart';

class AppBarCustombyMe extends StatelessWidget implements PreferredSizeWidget {
  final double _prefferedHeight = 60.0;

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _prefferedHeight,
        alignment: FractionalOffset.center,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 12,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        //container dalam(seconder) untuk membungkus material di dalam kontainer primer
        child: Container(
          //diberi margin agar rapih
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('assets/logo-ambis-kampus.png',width: 30.5,),
              Image.asset('assets/1x/notif.png'),
            ],),
        )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);

}
