import 'package:flutter/material.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/DataCompletion/KelasLangganan.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/DesktopCloseButton.dart';

class DaftarKelasLangganan extends StatelessWidget {
  static String route = "daftar_kelas_langganan";

  final Args args;

  const DaftarKelasLangganan({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mobile = !args.api.screenAdapter.isDesktop;

    if (mobile)
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(padding: EdgeInsets.all(20), child: mainBody()),
          ),
        ),
      );

    final scrollController = ScrollController();

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Align(
                alignment: Alignment.centerRight,
                child: DesktopCloseButton(api: args.api),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: mainBody(),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget mainBody() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text("Kelas Langganan",
            style: TextStyle(
                color: mHeadingText,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 3),
        Text(
          "Tambah kelas langganan",
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
        ),
        SizedBox(height: 20),
        KelasLangganan(
          api: args.api,
          kelases: args.data,
        ),
      ],
    );
  }
}
