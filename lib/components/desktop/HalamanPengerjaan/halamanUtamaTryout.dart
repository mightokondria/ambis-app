import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/Helpers.dart';
import 'package:mentoring_id/api/TryoutTimer.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class HalamanUtamaTryout extends StatefulWidget {
  final Map<String, dynamic> data;

  const HalamanUtamaTryout({Key key, this.data}) : super(key: key);

  @override
  _HalamanUtamaTryoutState createState() => _HalamanUtamaTryoutState(data);
}

class _HalamanUtamaTryoutState extends State<HalamanUtamaTryout> {
  final Map<String, dynamic> data;
  TryoutSession session;
  int posisiSoal = 0;
  API api;
  Timer tryoutTimer;

  _HalamanUtamaTryoutState(this.data) {
    session = data['data'];
    api = data['api'];
  }

  pindahSoal({int indexSoal}) {
    setState(() {
      posisiSoal = indexSoal;
    });
  }

  jawabSoal(Pilihan data) {
    api.tryout.jawabSoal(session.session, session.noSesi, data).then((value) {
      setState(() {
        session.soal = session.soal.map((soal) {
          if (soal.noSesiSoal == data.noSesiSoal) {
            soal.pilihan = soal.pilihan.map((pilihan) {
              pilihan.dipilih = false;
              if (pilihan.noSesiSoalPilihan == data.noSesiSoalPilihan)
                pilihan.dipilih = true;

              return pilihan;
            }).toList();
          }

          return soal;
        }).toList();
      });
    });
  }

  akhiri() {
    tryoutTimer.cancel();
    api.tryout.akhiri(session);
  }

  akhiriFromUser() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Kamu yakin ingin mengakhiri sesi ini?"),
            actions: [
              TextButton(
                child: Text("AKHIRI"),
                onPressed: akhiri,
              ),
              TextButton(
                child: Text("BATAL"),
                onPressed: () => api.closeDialog(),
              )
            ],
          );
        });
  }

  bool sudahDijawab(int noSoal) {
    bool dijawab = false;

    session.soal[noSoal].pilihan.forEach((pilihan) {
      if (pilihan.dipilih) dijawab = true;
    });

    return dijawab;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      color: Colors.white,
      child: api.screenAdapter.isDesktop
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TryoutBody(this),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, right: 130, left: 50),
                    child: Column(
                      children: [
                        TryoutTimerWidget(instance: this),
                        SizedBox(height: 10),
                        ListNomorSoal(instance: this)
                      ],
                    ),
                  ),
                ),
              )
            ])
          : InteractiveViewer(
              panEnabled: false,
              maxScale: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TryoutTimerWidget(
                      instance: this,
                    ),
                    SizedBox(height: 30),
                    TryoutBody(
                      this,
                      mobile: true,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                          enabled: posisiSoal > 0,
                          onTap: () => pindahSoal(indexSoal: posisiSoal - 1),
                          value: "<",
                        )),
                        SizedBox(width: 10),
                        Expanded(
                            child: CustomButton(
                          enabled: posisiSoal < session.soal.length - 1,
                          onTap: () => pindahSoal(indexSoal: posisiSoal + 1),
                          value: ">",
                        )),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListMateriTryout(session.nmTryout, session.materi),
                        ListNomorSoal(instance: this),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class TryoutBody extends StatelessWidget {
  final _HalamanUtamaTryoutState instance;
  final bool mobile;

  const TryoutBody(this.instance, {this.mobile: false});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final int posisiSoal = instance.posisiSoal;
    final TryoutSession session = instance.session;
    final bool sudahDijawab = instance.sudahDijawab(posisiSoal);

    return Container(
      width: mobile ? width : width * .65,
      padding: EdgeInsets.all(mobile ? 0 : 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            padding: EdgeInsets.all(mobile ? 0 : 10),
            decoration: BoxDecoration(
              color: sudahDijawab ? activeGreenColor : Colors.transparent,
              border: Border.all(
                  color: sudahDijawab ? activeGreenColor : Color(0xFFEEEEEE),
                  width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Text((posisiSoal + 1).toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: sudahDijawab ? Colors.white : Color(0xFF555555))),
            ),
          ),
          SizedBox(height: 10),
          Html(
            data: session.soal[posisiSoal].isiSoal.replaceAll(
                "https://server.mentoringid.com/", instance.api.defaultAPI),
            style: {"*": Style(lineHeight: LineHeight.number(1.5))},
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: session.soal[posisiSoal].pilihan
                .map((e) => GestureDetector(
                      onTap: () => instance.jawabSoal(e),
                      child: Column(
                        children: [
                          PilihanJawaban(
                            data: e,
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class PilihanJawaban extends StatelessWidget {
  PilihanJawaban({Key key, this.data}) : super(key: key);

  final Pilihan data;

  @override
  Widget build(BuildContext context) {
    final bool selected = data.dipilih;

    return Clickable(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: selected ? activeGreenColor : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: selected
                ? null
                : Border.all(width: 2, color: Colors.black.withOpacity(.05))),
        child: Html(
          data: data.isiPilihan,
          style: {
            "*": Style(color: selected ? Colors.white : Color(0xFF555555))
          },
        ),
      ),
    );
  }
}

class TryoutTimerWidget extends StatefulWidget {
  final _HalamanUtamaTryoutState instance;

  const TryoutTimerWidget({Key key, this.instance}) : super(key: key);

  @override
  _TryoutTimerWidgetState createState() => _TryoutTimerWidgetState(instance);
}

class _TryoutTimerWidgetState extends State<TryoutTimerWidget> {
  final _HalamanUtamaTryoutState instance;
  TryoutSession data;
  DateTime sisaWaktu = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  double progressWaktu = 1;
  API api;

  _TryoutTimerWidgetState(this.instance) {
    data = instance.session;
    api = instance.api;

    instance.tryoutTimer = TryoutTimer(
        int.parse(data.durasi),
        data.timestamp,
        (date, progress) => setState(() {
              sisaWaktu = date;
              progressWaktu = progress;
            })).timer;
  }

  BoxDecoration getTimerDecoration({bool active: false, Color color}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: !active ? Colors.black.withOpacity(.05) : color);
  }

  Widget build(BuildContext context) {
    final List<int> waktu = [
      sisaWaktu.hour,
      sisaWaktu.minute,
      sisaWaktu.second
    ];
    final Color progressColor =
        Color.lerp(Colors.red, activeGreenColor, progressWaktu);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.nmMateri,
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        Text(
          waktu.map((e) => Helpers.makeDoubleDigits(e)).join(":"),
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        SizedBox(height: 20),
        Stack(
          children: [
            Container(
              decoration: getTimerDecoration(),
              width: double.infinity,
              height: 6,
            ),
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                  height: 6,
                  width: constraints.maxWidth * progressWaktu,
                  decoration:
                      getTimerDecoration(active: true, color: progressColor));
            }),
          ],
        ),
      ],
    );
  }
}

class ListNomorSoal extends StatelessWidget {
  ListNomorSoal({
    Key key,
    @required this.instance,
  }) {
    nomorSoal = instance.session.soal.asMap().keys.toList();
  }

  final _HalamanUtamaTryoutState instance;
  List<int> nomorSoal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 5,
            children: nomorSoal.map((e) {
              return Clickable(
                child: GestureDetector(
                  onTap: () {
                    instance.pindahSoal(indexSoal: e);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: (e == instance.posisiSoal)
                            ? Colors.blueAccent
                            : (instance.sudahDijawab(e))
                                ? activeGreenColor
                                : Color(0xFF666666),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    padding: EdgeInsets.all(3),
                    child: Center(
                        child: Text(
                      (e + 1).toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              );
            }).toList()),
        SizedBox(height: 20),
        CustomButton(
            value: "akhiri",
            onTap: instance.akhiriFromUser,
            style: CustomButtonStyle(
                color: Colors.redAccent, textColor: Colors.white))
      ],
    );
  }
}

class ListMateriTryout extends StatelessWidget {
  // final API api;
  final String activeMateri;
  final List<String> materi;
  int active;

  ListMateriTryout(this.activeMateri, this.materi) {
    active = materi.indexOf(activeMateri);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    materi.asMap().forEach((key, value) {
      final bool isActive = key <= active;
      final Color textColor = isActive ? Colors.white : Color(0xFF555555);

      children.add(Container(
        constraints: BoxConstraints(minWidth: 100),
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
            color: isActive ? activeGreenColor : Colors.black.withOpacity(.05),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Materi",
              style: TextStyle(color: textColor.withOpacity(.6), fontSize: 10),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ));
    });

    return Container(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: children,
      ),
    );
  }
}
