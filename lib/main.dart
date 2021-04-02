import 'package:mentoring_id/api/Handler.dart';
import 'package:mentoring_id/components/home_screen.dart';
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
    Handler api = Handler();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ambis Kampus',
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: FutureBuilder(
        future: api.init(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Splash();

          return HomeScreen();
        },
      ),
    );
  }
}
