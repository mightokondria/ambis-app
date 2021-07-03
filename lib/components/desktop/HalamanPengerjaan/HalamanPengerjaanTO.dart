import 'package:flutter/material.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/desktop/HalamanPengerjaan/HalamanUtamaTryout.dart';

class HalamanPengerjaanTO extends StatefulWidget {
  static String name = "kerjain";
  final Args args;

  const HalamanPengerjaanTO(this.args, {Key key}) : super(key: key);

  @override
  _HalamanPengerjaanTOState createState() =>
      _HalamanPengerjaanTOState(this.args);
}

class _HalamanPengerjaanTOState extends State<HalamanPengerjaanTO> {
  final Args args;
  final ScrollController scrollController = ScrollController();

  _HalamanPengerjaanTOState(this.args);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Scrollbar(
            controller: scrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                child: HalamanUtamaTryout(data: args))),
      ),
    );
  }
}
