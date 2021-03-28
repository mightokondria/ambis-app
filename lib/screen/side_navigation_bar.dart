import 'dart:html';

import 'package:ambis_app/reuseable/NavElement.dart';
import 'package:ambis_app/screen/Dashboard.dart';
import 'package:ambis_app/screen/Tryout.dart';
import 'package:ambis_app/screen/Update.dart';
import 'package:ambis_app/screen/bedah_jurusan.dart';
import 'package:ambis_app/screen/feedback.dart';
import 'package:ambis_app/screen/histori_tryout.dart';
import 'package:ambis_app/screen/pengaturan.dart';
import 'package:ambis_app/screen/rangkuman.dart';
import 'package:flutter/material.dart';
import 'package:ambis_app/constants/color_const.dart';

class SideNavigationBar extends StatefulWidget {

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {

  int selectedIndex = 0;
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          child: Container(
            child: Container(
              height: _height,
              width: 300,
              decoration: BoxDecoration(
                color: mGreyColor,
                // borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NavElement(selectedIndex, (int index){setState(() {selectedIndex = index;});}),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: mGreyColor,
            width: _width,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
              height: _height,
              width: 400,
                child: Builder(
                    builder: (context){
                      //DASHBOARD == 0
                      if (selectedIndex == 0){
                        return Dashboard();}
                      //UPDATE == 1
                      if (selectedIndex == 1){
                        return Update();}
                      //TRYOUT == 2
                      if (selectedIndex == 2){
                        return Tryout();}
                      //HISTORI TRYOUT == 3
                      if (selectedIndex == 3){
                        return HistoriTryout();}
                      //RANGKUMAN == 4
                      if (selectedIndex == 4){
                        return Rangkuman();}
                      //BEDAH JURUSAN == 5
                      if (selectedIndex == 5){
                        return BedahJurusan();}
                      //PENGATURAN
                      if (selectedIndex == 6){
                        return Pengaturan();}
                      //FeedBack
                      if (selectedIndex == 7){
                        return feedBack();}



                      return Container();
                      }
                ),
            ),)
          ),
        )
      ],
    );
  }
}
