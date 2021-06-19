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

  _HalamanPengerjaanTOState(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HalamanUtamaTryout(),
    );
  }
}
