import 'package:flutter/material.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/features/HalamanPengerjaan/HalamanUtamaTryout.dart';

class HalamanPengerjaanTO extends StatelessWidget {
  final Args args;
  final ScrollController scrollController = ScrollController();

  static String route = "kerjain";

  HalamanPengerjaanTO({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Scrollbar(
              controller: scrollController,
              isAlwaysShown: true,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: scrollController,
                  child: HalamanUtamaTryout(data: args))),
        ),
      ),
    );
  }
}
