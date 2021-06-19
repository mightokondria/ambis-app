import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/ScreenAdapter.dart';
import 'package:mentoring_id/components/Disconnected.dart';
import 'package:mentoring_id/constants/color_const.dart';

import 'api/Helpers.dart';
import 'components/Splash.dart';
import 'components/desktop/HalamanPengerjaan/HalamanPengerjaanTO.dart';

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
      theme: ThemeData(fontFamily: 'OpenSans', primaryColor: mPrimary),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        final List<String> route = settings.name.split("/");
        Widget child = Home();

        if (route[1] == HalamanPengerjaanTO.name)
          child = HalamanPengerjaanTO(settings.arguments);

        return PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation<double> animation, Animation<double> secondaryAnimation) {
          final scaleTransition =
              Tween<double>(begin: .9, end: 1).animate(animation);

          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: scaleTransition,
              child: child,
            ),
          );
        });
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

    // return HalamanPengerjaanTO({});
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
