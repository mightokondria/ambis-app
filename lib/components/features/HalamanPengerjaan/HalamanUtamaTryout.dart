import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/class/TryoutTimer.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/ContentLoading.dart';
import 'package:mentoring_id/reuseable/Information.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class HalamanUtamaTryout extends StatefulWidget {
  final Args data;

  const HalamanUtamaTryout({Key key, this.data}) : super(key: key);

  @override
  _HalamanUtamaTryoutState createState() => _HalamanUtamaTryoutState(data);
}

class _HalamanUtamaTryoutState extends State<HalamanUtamaTryout> {
  final Args data;
  TryoutSession session;
  int posisiSoal = 0;
  API api;
  Timer tryoutTimer;

  _HalamanUtamaTryoutState(this.data) {
    session = data.data['session'];
    api = data.api;
  }

  pindahSoal({int indexSoal}) {
    setState(() {
      posisiSoal = indexSoal;
    });
  }

  pindahSubmateri(String noSesi) {
    api.tryout.pindahMateri(session.session, noSesi).then((value) {
      setState(() {
        session = TryoutSession.parse(api.safeDecoder(value.body));
        posisiSoal = 0;
      });
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
    api.ui.showTryoutEndConfirmationDialog(akhiri);
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
    final Widget stop = session.onetime
        ? SomeInfo(
            api: api,
            message:
                "🤚STOP!🤚 Sebelum menekan akhiri,  selesaikan dulu submateri TWK TIU dan TKP. Untuk pindah submateri, kamu bisa menekan tab di atas.",
            config: "skdHowTo",
            color: Colors.red)
        : SizedBox();

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TryoutSubmateriUI(this),
                        SizedBox(
                          height: 5,
                        ),
                        stop,
                        SizedBox(
                          height: 10,
                        ),
                        TryoutTimerWidget(instance: this),
                        SizedBox(height: 10),
                        ListMateriTryout(session.nmTryout, session.materi),
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
                    TryoutSubmateriUI(this),
                    SizedBox(height: 5),
                    stop,
                    SizedBox(height: 15),
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
                        SizedBox(height: 10),
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
          NomorSoalAktif(
              mobile: mobile,
              sudahDijawab: sudahDijawab,
              posisiSoal: posisiSoal),
          SizedBox(height: 10),
          Html(
            data: session.soal[posisiSoal].isiSoal,
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
                            color: !e.dipilih
                                ? Colors.transparent
                                : activeGreenColor,
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

class NomorSoalAktif extends StatelessWidget {
  const NomorSoalAktif({
    Key key,
    @required this.mobile,
    @required this.sudahDijawab,
    @required this.posisiSoal,
  }) : super(key: key);

  final bool mobile;
  final bool sudahDijawab;
  final int posisiSoal;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class PilihanJawaban extends StatelessWidget {
  PilihanJawaban({Key key, this.data, this.color: Colors.transparent})
      : super(key: key);

  final Pilihan data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool selected = data.dipilih || color != Colors.transparent;

    return Clickable(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color,
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
  _TryoutTimerWidgetState createState() => _TryoutTimerWidgetState();
}

class _TryoutTimerWidgetState extends State<TryoutTimerWidget> {
  TryoutSession data;
  DateTime sisaWaktu = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  double progressWaktu = 1;
  API api;

  updateDate(DateTime date, double progress) {
    setState(() {
      sisaWaktu = date;
      progressWaktu = progress;
    });
  }

  BoxDecoration getTimerDecoration({bool active: false, Color color}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: !active ? Colors.black.withOpacity(.05) : color);
  }

  Widget build(BuildContext context) {
    final instance = widget.instance;

    data = widget.instance.session;
    api = widget.instance.api;

    if (instance.tryoutTimer == null) {
      Timer.run(() => instance.tryoutTimer =
          TryoutTimer(int.parse(data.durasi), data.timestamp, updateDate)
              .timer);

      return ContentLoading();
    }

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
  });

  final _HalamanUtamaTryoutState instance;

  @override
  Widget build(BuildContext context) {
    final nomorSoal = instance.session.soal.asMap().keys.toList();

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
                  child: NomorSoal(
                    color: (e == instance.posisiSoal)
                        ? Colors.blueAccent
                        : (instance.sudahDijawab(e))
                            ? activeGreenColor
                            : Color(0xFF666666),
                    nomor: e,
                  ),
                ),
              );
            }).toList()),
        SizedBox(height: 20),
        CustomButton(
            value: "akhiri",
            onTap: instance.akhiriFromUser,
            style: CustomButtonStyle(
                color: Colors.redAccent, textColor: Colors.white)),
        SizedBox(height: 10),
      ],
    );
  }
}

class NomorSoal extends StatelessWidget {
  const NomorSoal({
    Key key,
    this.color,
    this.nomor,
  }) : super(key: key);

  final Color color;
  final int nomor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(5))),
      padding: EdgeInsets.all(3),
      child: Center(
          child: Text(
        (nomor + 1).toString(),
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}

class ListMateriTryout extends StatefulWidget {
  // final API api;
  final String activeMateri;
  final List<String> materi;

  ListMateriTryout(this.activeMateri, this.materi);

  @override
  _ListMateriTryoutState createState() => _ListMateriTryoutState();
}

class _ListMateriTryoutState extends State<ListMateriTryout> {
  @override
  Widget build(BuildContext context) {
    final active = widget.materi.indexOf(widget.activeMateri);
    List<Widget> children = [];

    widget.materi.asMap().forEach((key, value) {
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

class TryoutSubmateriUI extends StatelessWidget {
  final _HalamanUtamaTryoutState instance;
  TryoutSubmateriUI(this.instance);

  @override
  Widget build(BuildContext context) {
    final List<TryoutSessionSubmateri> submateri = instance.session.submateri;
    if (instance.session.onetime) {
      return Container(child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: submateri.map((e) {
                final Color color = e.active ? mPrimary : Color(0xFFDDDDDD);
                return Expanded(
                  child: GestureDetector(
                    onTap: () => instance.pindahSubmateri(e.materi.noSesi),
                    child: Clickable(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 3,
                              width: constraints.maxWidth / submateri.length,
                              color: color,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              // decoration: CustomCard.decoration(color: color),
                              child: Text(e.materi.nmMateri,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList());
        },
      ));
    } else {
      return SizedBox(height: 0);
    }
  }
}
