import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/api/models/Nilai.dart';
import 'package:mentoring_id/components/Messages.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/ScoreBoard.dart';

abstract class HistoryTryout {
  static String route = "history_tryout";

  static Widget mobile(Args data) {
    return _HistoryTryoutMobile(data: data);
  }

  static Widget desktop(Args data) {
    return null;
  }

  static List<double> calculateIkhtisar(List<HistoryTryoutSession> sessions) {
    final List<double> result = [0, 0, 0];

    sessions.forEach((val) {
      final double n = (val.nilai != null) ? val.nilai : 0;
      final List<double> peri = [
        val.peringkat.nasional.peringkat,
        val.peringkat.jurusan.peringkat
      ];

      result[2] += n;

      if (result[1] < n) result[1] = n;

      peri.forEach((p) {
        if (result[0] > p && p > 0) result[0] = p;
      });
    });

    result[2] /= (sessions.length < 1) ? 1 : sessions.length;

    if (result[0] == double.infinity) result[0] = 0;

    return result;
  }

  static Widget history(List<HistoryTryoutSession> sessions,
      {@required API api, @required BuildContext context, bool mobile: false}) {
    return sessions.isNotEmpty
        ? GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: sessions
                .map((data) => GestureDetector(
                      onTap: () => api.nilai.api.nilai.api.nilai.api.nilai
                          .getNilai(data.session.session),
                      child: TryoutHistoryElement(
                          session: data, api: api, mobile: mobile),
                    ))
                .toList(),
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
          );
  }
}

class _HistoryTryoutMobile extends StatefulWidget {
  final Object data;

  const _HistoryTryoutMobile({Key key, this.data}) : super(key: key);

  @override
  _HistoryTryoutMobileState createState() => _HistoryTryoutMobileState(data);
}

class _HistoryTryoutMobileState extends State<_HistoryTryoutMobile> {
  final Args data;
  List<HistoryTryoutSession> sessions;
  API api;

  _HistoryTryoutMobileState(this.data) {
    sessions = data.data;
    api = data.api;
  }

  @override
  Widget build(BuildContext context) {
    // CALCULATING
    final List<double> ikhtisar = HistoryTryout.calculateIkhtisar(sessions);

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
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 20,
                        color: Color(0xFFCCCCCC),
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
                IkhtisarHistory(
                  data: ikhtisar,
                ),
                SizedBox(height: 15),
                HistoryTryout.history(sessions,
                    context: context, api: api, mobile: true)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IkhtisarHistory extends StatelessWidget {
  final List<double> data;

  const IkhtisarHistory({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> dString = data.map((e) => e.round().toString()).toList();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScoreBoard(
                title: "Peringkat",
                score: dString[0],
                textColor: Color(0xFF5555555),
              ),
              ScoreBoard(
                title: "Nilai",
                score: dString[1],
                textColor: Color(0xFF5555555),
              ),
              ScoreBoard(
                title: "Rata-rata",
                score: dString[2],
                textColor: Color(0xFF5555555),
              ),
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
}

class TryoutHistoryElement extends StatelessWidget {
  final bool mobile;
  final HistoryTryoutSession session;
  final API api;

  const TryoutHistoryElement(
      {Key key, this.mobile: true, this.session, this.api})
      : super(key: key);

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
            ((session.nilai != null) ? session.nilai.round() : 0).toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color(0xFF555555)),
          ),
          SizedBox(height: 10),
          Text(session.session.nmp,
              style: TextStyle(
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          Text(session.date,
              style: TextStyle(color: Color(0xFFB5B5B5), fontSize: 12)),
        ],
      ),
    );
  }
}
