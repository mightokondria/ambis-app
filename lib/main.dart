import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/Device.dart';
import 'package:flutter/material.dart';

import 'components/Splash.dart';
import 'components/desktop/screens/Dashboard.dart';

// MENGGOKIL

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API api = API();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentoring',
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: FutureBuilder(
        future: api.init(),
        builder: (context, snapshot) {
          print(snapshot);
          if(!snapshot.hasData) return Splash();
          return Device(api);
        },
      ),
    );
  }
}
