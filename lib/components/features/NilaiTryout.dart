import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Nilai.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/Information.dart';
import 'package:mentoring_id/reuseable/ScoreBoard.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

API publicAPI;
String publicSession;

abstract class NilaiTryout {
  static String route = "nilai";

  static Widget mobile(Args args) {
    return _NilaiTryoutMobile(args);
  }

  static Widget desktop(Args args) {
    return _NilaiTryoutDesktop(args: args);
  }
}

class _NilaiTryoutMobile extends StatelessWidget {
  NilaiPaket data;
  API api;

  _NilaiTryoutMobile(Args args) {
    data = args.data;
    api = publicAPI = args.api;
    publicSession = data.nilai.session.session;
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
              NilaiAndPeringkat(nilai: data.nilai, api: api),
              SizedBox(height: 30),
              Column(
                children: data.data
                    .map((e) => Column(
                          children: [
                            IkhtisarTryoutMateri(
                              data: e,
                            ),
                            SizedBox(height: 10)
                          ],
                        ))
                    .toList(),
              ),
            ]),
          ),
        )));
  }
}

class _NilaiTryoutDesktop extends StatelessWidget {
  final Args args;
  API api;
  NilaiPaket data;

  _NilaiTryoutDesktop({Key key, this.args}) {
    api = publicAPI = args.api;
    data = args.data;

    publicSession = data.nilai.session.session;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mPrimary,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(30),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Clickable(
                      child: GestureDetector(
                          onTap: api.closeDialog,
                          child: Icon(Icons.close,
                              size: 25, color: Colors.white)))),
              Column(
                children: [
                  SizedBox(
                      height: (MediaQuery.of(context).size.height / 2) - 250),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            Text(data.nilai.session.nmp,
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.bold)),
                            NilaiAndPeringkat(
                              api: api,
                              nilai: data.nilai,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 80),
                      Expanded(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: data.data
                              .map((e) => SizedBox(
                                    width: 400,
                                    child: IkhtisarTryoutMateri(
                                      data: e,
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}

class NilaiAndPeringkat extends StatefulWidget {
  final Color textColor;
  final HistoryTryoutSession nilai;
  final API api;

  const NilaiAndPeringkat(
      {Key key, this.nilai, this.textColor: Colors.white, this.api})
      : super(key: key);

  @override
  _NilaiAndPeringkatState createState() => _NilaiAndPeringkatState();
}

class _NilaiAndPeringkatState extends State<NilaiAndPeringkat> {
  bool nasional = true;

  List<PeringkatList> trimPeringkat(PeringkatLevelModel peringkatLevel) {
    final List<PeringkatList> cache = [];
    final int peringkat = peringkatLevel.peringkat.toInt();
    final List<double> data = peringkatLevel.data;
    List<PeringkatList> trimmed = [];

    data.asMap().forEach((key, value) {
      cache.add(
          PeringkatList(key + 1, key == peringkat - 1, value.roundToDouble()));
    });

    if (peringkat > 5 && peringkat != data.length) {
      bool loop = true;
      int i = peringkat - 5;

      while (loop) {
        i++;

        if (trimmed.length >= 5 || cache.length <= i + 1) loop = false;

        trimmed.add(cache[i]);
      }
    } else if (peringkat == data.length) {
      final int start = peringkat - 5;
      trimmed = cache.getRange((start > 0) ? start : 0, peringkat).toList();
    } else
      try {
        trimmed = cache.getRange(0, 5).toList();
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
        SomeInfo(
          color: Colors.white,
          api: widget.api,
          message: "Klik tombol di atas untuk mengganti tingkatan peringkatmu",
          config: "peringkatSwitchGuide",
        ),
        SizedBox(height: 10),
        Text(
            "Peringkat ${peringkat.peringkat.toInt()} dari ${peringkat.jumlahPeserta} peserta",
            style: TextStyle(color: widget.textColor.withOpacity(.7))),
        SizedBox(height: 10),
        Column(
            children: peringkatData
                .map((e) => Column(
                      children: [
                        PeringkatElement(data: e),
                        SizedBox(height: 1),
                      ],
                    ))
                .toList()),
      ],
    );
  }
}

class PeringkatElement extends StatefulWidget {
  final PeringkatList data;
  const PeringkatElement({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _PeringkatElementState createState() => _PeringkatElementState();
}

class _PeringkatElementState extends State<PeringkatElement> {
  @override
  Widget build(BuildContext context) {
    return theWidget();
  }

  Transform theWidget() {
    return Transform.scale(
      scale: widget.data.active ? 1 : .9,
      child: Opacity(
        opacity: widget.data.active ? 1 : .5,
        child: Container(
            decoration: CustomCard.decoration(),
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
            child: Row(
              children: [
                Text(
                  widget.data.index.toString(),
                  style: TextStyle(
                      color: mPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(width: 20),
                Text(
                  widget.data.nilai.toString(),
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
}

class IkhtisarTryoutMateri extends StatelessWidget {
  final NilaiTryoutModel data;

  const IkhtisarTryoutMateri({Key key, this.data}) : super(key: key);

  NilaiBSK calculateBSK() {
    final List<NilaiSesi> sesi = data.sesi;
    final NilaiBSK nilai = NilaiBSK(0, 0, 0);

    sesi.forEach((e) {
      final NilaiModel n = e.nilai;

      nilai.benar += n.benar;
      nilai.kosong += n.kosong;
      nilai.salah += n.salah;
    });

    return nilai;
  }

  @override
  Widget build(BuildContext context) {
    final NilaiBSK bsk = calculateBSK();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.tryout.nmTryout,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScoreBoard(
                    title: "Benar",
                    score: bsk.benar.toString(),
                    textColor: Color(0xFF555555),
                  ),
                  ScoreBoard(
                    title: "Salah",
                    score: bsk.salah.toString(),
                    textColor: Color(0xFF555555),
                  ),
                  ScoreBoard(
                    title: "Kosong",
                    score: bsk.kosong.toString(),
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
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: data.sesi
                  .map((e) => NilaiSubmateri(
                        data: e,
                        dataTryout: data,
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class NilaiSubmateri extends StatelessWidget {
  final NilaiSesi data;
  final NilaiTryoutModel dataTryout;

  const NilaiSubmateri({
    Key key,
    this.data,
    this.dataTryout,
  }) : super(key: key);

  bahas() => publicAPI.nilai
      .bahas(publicSession, dataTryout.tryout.noTryout, data.materi.noSesi);

  Widget desktop() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 180,
      ),
      padding: EdgeInsets.all(25),
      decoration: CustomCard.decoration(shadow: false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.materi.nmMateri,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black38,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          Text(data.nilai.total.round().toString(),
              style: TextStyle(
                  color: Color(0xFF555555),
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          SizedBox(height: 5),
          CustomButton(
            value: "pembahasan",
            onTap: bahas,
            fill: false,
            style: CustomButtonStyle.semiPrimary(),
          )
        ],
      ),
    );
  }

  mobile() {
    return Container(
      decoration: CustomCard.decoration(),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.materi.nmMateri,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                Text(data.nilai.total.round().toString(),
                    style: TextStyle(
                        color: Color(0xFF555555),
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ],
            ),
          ),
          SizedBox(width: 10),
          CustomButton(
            style: CustomButtonStyle.primary(radius: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            value: "pembahasan",
            onTap: bahas,
            fill: false,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return publicAPI.screenAdapter.isDesktop ? desktop() : mobile();
  }
}

class PeringkatList {
  final int index;
  final bool active;
  final double nilai;

  PeringkatList(this.index, this.active, this.nilai);
}

class NilaiBSK {
  int benar, salah, kosong;

  NilaiBSK(this.benar, this.salah, this.kosong);
}
