import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/ScreenAdapter.dart';
import 'package:mentoring_id/components/Disconnected.dart';

import 'api/Helpers.dart';
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
      onGenerateRoute: (settings) {
        print(settings.name.split("/"));
        return MaterialPageRoute(builder: (context) {
          return Disconnected();
        });
      },
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

    Helpers.changeStatusBarColor();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return FutureBuilder(
      future: api.init(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Disconnected(api: api);
        } else if (!snapshot.hasData) return Splash();

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
