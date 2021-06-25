import 'package:flutter/material.dart';
import 'package:mentoring_id/api/Helpers.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/components/Messages.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';

class HistoryTryout extends StatefulWidget {
  final List<HistoryTryoutSession> session;

  const HistoryTryout({Key key, this.session}) : super(key: key);

  @override
  _HistoryTryoutState createState() => _HistoryTryoutState(session);
}

class _HistoryTryoutState extends State<HistoryTryout> {
  final List<HistoryTryoutSession> session;

  _HistoryTryoutState(this.session);

  @override
  Widget build(BuildContext context) {
    Helpers.changeStatusBarColor(color: Colors.white);

    // CALCULATING
    int peringkatMax = 0, nilaiMax = 0;
    double mean = 0;

    session.forEach((val) {
      final int n = val.nilai, p = val.peringkat;

      mean += n;

      if (nilaiMax < n) nilaiMax = n;
      if (peringkatMax < p) peringkatMax = p;
    });

    mean /= session.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          color: Color(0xFFCCCCCC),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "HISTORY TRYOUT",
                      style: TextStyle(
                          color: Color(0xFF777777),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                IkhtisarHistory(),
                SizedBox(height: 15),
                false
                    ? GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          TryoutHistoryElement(),
                          TryoutHistoryElement(),
                          TryoutHistoryElement(),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: 50),
                          Messages.message(
                              image: AssetImage("assets/img/msg/404.png"),
                              title: "Kosong",
                              content:
                                  "History tryout kamu masih kosong, lho! Yuk kerjain tryout dulu!"),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IkhtisarHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              scoreBoard("Peringkat", "0"),
              scoreBoard("Nilai", "0"),
              scoreBoard("Rata-rata", "0"),
            ],
          ),
          SizedBox(height: 15),
          Container(
            decoration: CustomCard.decoration(color: Colors.blue, radius: 5),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.white),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Data di atas adalah data tertinggi",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding scoreBoard(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
          Text(
            value,
            style: TextStyle(
                color: Color(0xFF555555),
                fontWeight: FontWeight.bold,
                fontSize: 36),
          )
        ],
      ),
    );
  }
}

class TryoutHistoryElement extends StatelessWidget {
  final bool mobile;

  const TryoutHistoryElement({Key key, this.mobile: true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mobile
          ? BoxDecoration(
              border: Border.all(width: 1.3, color: Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
          : CustomCard.decoration(),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "544",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color(0xFF555555)),
          ),
          SizedBox(height: 10),
          Text("SAINTEK 3",
              style: TextStyle(
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          Text("27 Mar 2003",
              style: TextStyle(color: Color(0xFFB5B5B5), fontSize: 12)),
        ],
      ),
    );
  }
}
