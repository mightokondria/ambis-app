import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mentoring_id/api/models/Pembahasan.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Information.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'HalamanPengerjaan/HalamanUtamaTryout.dart';

class HalamanPembahasan extends StatefulWidget {
  static String route = "bahas";

  final Args args;

  HalamanPembahasan({Key key, this.args});

  @override
  _HalamanPembahasanState createState() => _HalamanPembahasanState();
}

class _HalamanPembahasanState extends State<HalamanPembahasan> {
  int posisiSoal = 0;
  Pembahasan session;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    session = widget.args.data;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        isAlwaysShown: widget.args.api.screenAdapter.isDesktop,
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: widget.args.api.screenAdapter.isDesktop
              ? Stack(
                  children: [
                    Positioned(
                        top: 30,
                        right: 30,
                        child: Clickable(
                            child: GestureDetector(
                                onTap: widget.args.api.closeDialog,
                                child: Icon(Icons.close,
                                    size: 25, color: Colors.black54)))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PembahasanBody(this),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                KotakPembahasan(
                                  session: session,
                                  posisiSoal: posisiSoal,
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(right: 130),
                                  child: DaftarNomorPembahasan(
                                    instance: this,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(children: [
                    SizedBox(height: 20),
                    SomeInfo(
                        api: widget.args.api,
                        message:
                            "Jangan sampai tersesat! Pembahasan dan tombol kembali ada di bawah😉",
                        config: "mobilePembahasanInformation"),
                    PembahasanBody(this, mobile: true),
                    SizedBox(height: 10),
                    KotakPembahasan(session: session, posisiSoal: posisiSoal),
                    SizedBox(
                      height: 10,
                    ),
                    DaftarNomorPembahasan(instance: this),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      value: "tutup",
                      onTap: widget.args.api.closeDialog,
                    )
                  ]),
                ),
        ),
      ),
    );
  }

  changeSoal(int index) => setState(() {
        posisiSoal = index;
      });
}

class PembahasanBody extends StatelessWidget {
  final _HalamanPembahasanState instance;
  final bool mobile;

  const PembahasanBody(this.instance, {this.mobile: false});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final int posisiSoal = instance.posisiSoal;
    final Pembahasan session = instance.session;
    final bool sudahDijawab = session.pembahasan[posisiSoal].status != 0;

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
            data: session.pembahasan[posisiSoal].isiSoal,
            style: {"*": Style(lineHeight: LineHeight.number(1.5))},
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: session.pembahasan[posisiSoal].pilihan.map((e) {
              final Pilihan pl = e.pilihan;
              Color color = Colors.transparent;

              if ((pl.dipilih && e.jawaban) || e.jawaban)
                color = activeGreenColor;
              else if (pl.dipilih && !e.jawaban) color = Colors.redAccent;

              return Column(
                children: [
                  PilihanJawaban(
                    data: pl,
                    color: color,
                  ),
                  SizedBox(height: 10)
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class KotakPembahasan extends StatelessWidget {
  final Pembahasan session;
  final int posisiSoal;

  const KotakPembahasan({Key key, this.session, this.posisiSoal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PEMBAHASAN",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF555555)),
        ),
        Html(
          data: session.pembahasan[posisiSoal].pembahasan,
          style: {"*": Style(lineHeight: LineHeight.number(1.5))},
        ),
      ],
    );
  }
}

class DaftarNomorPembahasan extends StatelessWidget {
  final _HalamanPembahasanState instance;

  DaftarNomorPembahasan({Key key, this.instance});

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    final data = instance.session.pembahasan;

    data.asMap().forEach((k, e) {
      Color color = Color(0xFF666666);

      if (e.status == 1)
        color = Colors.redAccent;
      else if (e.status == 2) color = activeGreenColor;

      if (k == instance.posisiSoal) color = Colors.blue;

      children.add(Clickable(
          child: GestureDetector(
              onTap: () => instance.changeSoal(k),
              child: NomorSoal(nomor: k, color: color))));
    });

    return GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: children);
  }
}
