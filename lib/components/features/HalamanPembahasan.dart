import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mentoring_id/api/models/Pembahasan.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/features/HalamanPengerjaan/HalamanUtamaTryout.dart';
import 'package:mentoring_id/constants/color_const.dart';

import 'HalamanPengerjaan/HalamanUtamaTryout.dart';

class HalamanPembahasan extends StatelessWidget {
  static String route = "bahas";

  final Args args;
  int posisiSoal = 0;
  Pembahasan session;

  HalamanPembahasan({Key key, this.args}) {
    session = args.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: args.api.screenAdapter.isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PembahasanBody(this),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        KotakPembahasan(
                          session: session,
                          posisiSoal: posisiSoal,
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Column(
                children: [PembahasanBody(this, mobile: true)],
              ),
      ),
    );
  }
}

class PembahasanBody extends StatelessWidget {
  final HalamanPembahasan instance;
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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
      ),
    );
  }
}

class DaftarNomorPembahasan extends StatelessWidget {
  final List<PembahasanSoal> data;

  const DaftarNomorPembahasan({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    data.asMap().forEach((k, e) {
      Color color = Color(0xFF666666);

      if (e.status == 1)
        color = Colors.redAccent;
      else if (e.status == 2) color = activeGreenColor;

      children.add(NomorSoal(nomor: k, color: color));
    });

    return Wrap(children: children, spacing: 5, runSpacing: 5);
  }
}
