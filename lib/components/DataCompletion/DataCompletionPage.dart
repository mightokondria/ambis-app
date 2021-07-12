import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/components/DataCompletion/KelasLangganan.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Steps.dart';

import 'AdditionalDataForm.dart';

class DataCompletionPage extends StatefulWidget {
  final API api;
  DataCompletionPage(this.api);

  @override
  State<DataCompletionPage> createState() => DataCompletionPageState(api);
}

class DataCompletionPageState extends State<DataCompletionPage> {
  final API api;
  bool isDesktop;
  int step;
  List<KelasLanggananModel> kelases = [];

  DataCompletionPageState(this.api) {
    isDesktop = api.screenAdapter.isDesktop;
    step = api.data.initialData.ready ? 2 : 1;
  }

  @override
  initState() {
    if (step == 2)
      api.dataSiswa.getKelasLangganan().then((value) => setState(() {
            kelases = value;
          }));
  }

  changeStep(int target) => setState(() {
        step = target;
      });

  registerKelases(List<KelasLanggananModel> daftar) => setState(() {
        kelases = daftar;
      });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final width = mediaQuery.width;
    final Color color = mHeadingText.withOpacity(.03);
    final double horizontalMargin = (width >= 646)
        ? (width >= 1024)
            ? width * .3
            : width * .2
        : 20;
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Scrollbar(
          isAlwaysShown: isDesktop,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalMargin),
                      child: Column(
                        children: [
                          Text("Tinggal beberapa langkah lagi!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: mHeadingText,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(height: 20),
                          Steps(
                            activeIndex: step,
                            items: [
                              "Daftar menggunakan email",
                              "Isi identitas tambahan",
                              "Langganan kelas",
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: (step == 1)
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalMargin),
                              child: AdditionalDataForm(
                                parent: this,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: KelasLangganan(
                                api: api,
                                kelases: kelases,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
