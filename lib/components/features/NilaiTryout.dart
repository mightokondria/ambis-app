import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Nilai.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/ScoreBoard.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

abstract class NilaiTryout {
  static String route = "nilai";

  static Widget mobile(Args args) {
    return _NilaiTryoutMobile(args);
  }

  static Widget desktop(Args args) {
    return _NilaiTryoutMobile(args);
  }
}

class _NilaiTryoutMobile extends StatelessWidget {
  NilaiPaket data;
  API api;

  _NilaiTryoutMobile(Args args) {
    data = args.data["data"];
    api = args.api;
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = mPrimary;

    return Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    data.nilai.session.nmp,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 30),
              NilaiAndPeringkat(
                nilai: data.nilai,
              ),
              SizedBox(height: 30),
              IkhtisarTryoutMateri(),
            ]),
          ),
        )));
  }
}

class NilaiAndPeringkat extends StatefulWidget {
  final Color textColor;
  final HistoryTryoutSession nilai;

  const NilaiAndPeringkat({Key key, this.nilai, this.textColor: Colors.white})
      : super(key: key);

  @override
  _NilaiAndPeringkatState createState() => _NilaiAndPeringkatState();
}

class _NilaiAndPeringkatState extends State<NilaiAndPeringkat> {
  bool nasional = true;

  Widget peringkatElement(PeringkatList data) {
    return Transform.scale(
      scale: data.active ? 1 : .9,
      child: Opacity(
        opacity: data.active ? 1 : .5,
        child: Container(
            decoration: CustomCard.decoration(),
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
            child: Row(
              children: [
                Text(
                  data.index.toString(),
                  style: TextStyle(
                      color: mPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(width: 20),
                Text(
                  data.nilai.toString(),
                  style: TextStyle(
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            )),
      ),
    );
  }

  List<PeringkatList> trimPeringkat(PeringkatLevelModel peringkatLevel) {
    final List<PeringkatList> cache = [];
    final int peringkat = peringkatLevel.peringkat.toInt();
    final List<double> data = peringkatLevel.data;
    List<PeringkatList> trimmed = [];

    data.asMap().forEach((key, value) {
      cache.add(PeringkatList(key + 1, key == peringkat - 1, value));
    });

    if (peringkat > 5 && peringkat != data.length) {
      bool loop = true;
      int i = peringkat - 2;

      while (loop) {
        i++;

        if (trimmed.length >= 5 || cache.length <= i + 1)
          loop = false;
        else
          trimmed.add(cache[i]);
      }
    } else if (peringkat == data.length) {
      final int start = peringkat - 5;
      trimmed = cache.getRange((start > 0) ? start : 0, peringkat).toList();
    } else
      try {
        trimmed = cache.getRange(0, 5);
      } catch (e) {
        trimmed = cache;
      }

    return trimmed;
  }

  @override
  Widget build(BuildContext context) {
    final PeringkatLevelModel peringkat = nasional
        ? widget.nilai.peringkat.nasional
        : widget.nilai.peringkat.jurusan;
    final List<PeringkatList> peringkatData = trimPeringkat(peringkat);
    final String persentase = widget.nilai.persentase.toString();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(widget.nilai.nilai.round().toString(),
                style: TextStyle(
                    color: widget.textColor,
                    fontSize: 50,
                    fontWeight: FontWeight.bold)),
            Transform.translate(
                offset: Offset(0, -10),
                child: Text(
                    ((persentase.length > 4)
                            ? persentase.substring(0, 4)
                            : persentase) +
                        "%",
                    style: TextStyle(
                        color: widget.textColor.withOpacity(.6),
                        fontSize: 15))),
          ],
        ),
        CustomButtonTab(
            mPrimary,
            Colors.white,
            [
              CustomButtonTab.button("Nasional"),
              CustomButtonTab.button("Jurusan")
            ],
            (index) => setState(() {
                  nasional = index == 1;
                })),
        SizedBox(height: 10),
        Text(
            "Peringkat ${peringkat.peringkat.toInt()} dari ${peringkat.jumlahPeserta} peserta",
            style: TextStyle(color: widget.textColor.withOpacity(.7))),
        SizedBox(height: 10),
        Column(
            children: peringkatData
                .map((e) => Column(
                      children: [
                        peringkatElement(e),
                        SizedBox(height: 2),
                      ],
                    ))
                .toList()),
      ],
    );
  }
}

class IkhtisarTryoutMateri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("SAINTEK 3",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: CustomCard.decoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ScoreBoard(
                    title: "Peringkat",
                    score: "69",
                    textColor: Color(0xFF555555),
                  ),
                  ScoreBoard(
                    title: "Nilai",
                    score: "318",
                    textColor: Color(0xFF555555),
                  ),
                  ScoreBoard(
                    title: "Rata-rata",
                    score: "88",
                    textColor: Color(0xFF555555),
                  ),
                ],
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(0, -20),
          child: Container(
            width: double.infinity,
            decoration:
                CustomCard.decoration(color: Colors.white.withOpacity(.5)),
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 35),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                NilaiSubmateri(),
                NilaiSubmateri(),
                NilaiSubmateri(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NilaiSubmateri extends StatelessWidget {
  const NilaiSubmateri({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: CustomCard.decoration(shadow: false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BIOLOGI 3",
            style: TextStyle(
                color: Colors.black38,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          Text("302",
              style: TextStyle(
                  color: Color(0xFF555555),
                  fontWeight: FontWeight.bold,
                  fontSize: 30))
        ],
      ),
    );
  }
}

class PeringkatList {
  final int index;
  final bool active;
  final double nilai;

  PeringkatList(this.index, this.active, this.nilai);
}
