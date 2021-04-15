import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';

import 'input/CustomButton.dart';

class KelasLanggananList extends StatelessWidget {
  final Color color;
  final KelasLanggananModel data;
  final API api;
  final money = new NumberFormat("##,###.00", "in-ID");

  KelasLanggananList({Key key, this.color: Colors.white, this.data, this.api})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: CustomCard.decoration(color: color, radius: 18),
      padding: EdgeInsets.all(25),
      width: (width >= 680) ? 300 : double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            data.nmAkun,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: mHeadingText,
            ),
          ),
          Text(
            data.waktuAktif + " bulan membership",
            textAlign: TextAlign.center,
            style: TextStyle(color: mHeadingText.withOpacity(.2), fontSize: 14),
          ),
          SizedBox(height: 30),
          Column(
            children: data.menu
                .map((e) => KelasLanggananMenu(
                      menu: e.nmMenu,
                    ))
                .toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Rp. " + money.format(int.parse(data.hrgSblmDiskon)),
                style: TextStyle(
                    color: Colors.black45,
                    decoration: TextDecoration.lineThrough)),
          ), // HARGA STLH DISKON
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Rp. " + money.format(int.parse(data.hrgStlhDiskon)),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: 20)),
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            radius: 20,
            value: "Langganan",
            color: mPrimary,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}

class KelasLanggananMenu extends StatelessWidget {
  final String menu;

  const KelasLanggananMenu({Key key, this.menu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {0: FixedColumnWidth(13.0), 1: FixedColumnWidth(10)},
            children: [
              TableRow(children: [
                TableCell(
                    child: Image.asset(
                        "assets/img/fancies/kelas-langganan-menu.png")),
                TableCell(
                  child: SizedBox(),
                ),
                TableCell(
                  child: Text(
                    menu,
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ])
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
