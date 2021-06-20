import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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

  _HalamanUtamaTryoutState(this.data) {
    session = data['data'];
  }

  pindahSoal({int indexSoal}) {
    setState(() {
      posisiSoal = indexSoal;
    });
  }

  jawabSoal(Pilihan data) {
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
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 30),
      color: Colors.white,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: size.width * .65,
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Html(
                data: session.soal[posisiSoal].isiSoal,
                style: {"*": Style(lineHeight: LineHeight.number(1.5))},
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: session.soal[posisiSoal].pilihan
                    .map((e) => GestureDetector(
                          onTap: () => jawabSoal(e),
                          child: PilihanJawaban(
                            data: e,
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: size.height,
            child: Padding(
              padding: EdgeInsets.only(top: 30, right: 130, left: 50),
              child: TryoutIdentityWidget(instance: this),
            ),
          ),
        )
      ]),
    );
  }
}

class PilihanJawaban extends StatelessWidget {
  PilihanJawaban({Key key, this.data}) : super(key: key);

  final Pilihan data;

  @override
  Widget build(BuildContext context) {
    final bool selected = data.dipilih;

    return Column(
      children: [
        Clickable(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: selected ? activeGreenColor : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: selected
                    ? null
                    : Border.all(
                        width: 2, color: Colors.black.withOpacity(.05))),
            child: Row(
              children: [
                // Text(
                //   "A",
                //   style: style,
                // ),
                // SizedBox(width: 20),
                Html(
                  data: data.isiPilihan,
                  shrinkWrap: true,
                  style: {
                    "*": Style(
                        color: selected ? Colors.white : Color(0xFF555555))
                  },
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}

class TryoutIdentityWidget extends StatefulWidget {
  final _HalamanUtamaTryoutState instance;

  const TryoutIdentityWidget({Key key, this.instance}) : super(key: key);

  @override
  _TryoutIdentityWidgetState createState() =>
      _TryoutIdentityWidgetState(instance);
}

class _TryoutIdentityWidgetState extends State<TryoutIdentityWidget> {
  final _HalamanUtamaTryoutState instance;
  List<int> nomorSoal;
  TryoutSession data;
  int i = 0;

  _TryoutIdentityWidgetState(this.instance) {
    data = instance.session;
    nomorSoal = this.data.soal.asMap().keys.toList();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        i++;
      });
    });
  }

  BoxDecoration getTimerDecoration({bool active: false}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: !active ? Colors.black.withOpacity(.05) : activeGreenColor);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SAINTEK 3",
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        Text(
          i.toString(),
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
                width: constraints.maxWidth * .99,
                decoration: getTimerDecoration(active: true),
              );
            }),
          ],
        ),
        SizedBox(height: 10),
        ListMateriTryout(data.nmTryout, data.materi),
        SizedBox(height: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 230),
          child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              shrinkWrap: true,
              crossAxisCount: 5,
              children: nomorSoal
                  .map((e) => Clickable(
                        child: GestureDetector(
                          onTap: () {
                            instance.pindahSoal(indexSoal: e);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: (e == instance.posisiSoal)
                                    ? activeGreenColor
                                    : Color(0xFF666666),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(3),
                            child: Center(
                                child: Text(
                              (e + 1).toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ))
                  .toList()),
        ),
        SizedBox(height: 20),
        CustomButton(
            value: "tutup",
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
