import 'package:flutter/material.dart';
import 'package:mentoring_id/components/desktop/HalmamanPengerjaan/HalamanUtamaTryout.dart';

class HalamanPengerjaanTO extends StatefulWidget {
  static String name = "kerjain";
  final Object args;

  const HalamanPengerjaanTO(this.args, {Key key}) : super(key: key);

  @override
  _HalamanPengerjaanTOState createState() =>
      _HalamanPengerjaanTOState(this.args);
}

class _HalamanPengerjaanTOState extends State<HalamanPengerjaanTO> {
  final Object args;
  final ScrollController scrollController = ScrollController();

  _HalamanPengerjaanTOState(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
          controller: scrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              child: HalamanUtamaTryout(data: args))),
    );
  }
}
