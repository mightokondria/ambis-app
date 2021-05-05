import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/ScreenAdapter.dart';
import 'package:mentoring_id/components/Disconnected.dart';

import 'components/Splash.dart';
import 'components/desktop/HalmamanPengerjaan/pengerjaan_to.dart';

// MENGGOKIL

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Mentoring.id',
      theme: ThemeData(fontFamily: 'OpenSans'),
      initialRoute: "/",
      routes: {
        '/': (context) => Home(),
        '/tryout': (context) => halaman_pengerjaan_to()
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API api = API(context);
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: api.init(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Disconnected();
        else if (!snapshot.hasData) return Splash();

        return Scaffold(body: Builder(builder: (context) {
          api.context = context;

          return ScreenAdapter(
            api: api,
            width: width,
          );
        }));
      },
    );
  }
}
