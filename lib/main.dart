import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/ScreenAdapter.dart';
import 'package:mentoring_id/components/Disconnected.dart';
import 'package:mentoring_id/components/desktop/PendingInvoice.dart';
import 'package:mentoring_id/components/mobile/Login.dart';
import 'package:mentoring_id/components/mobile/PendingInvoice.dart';
import 'package:mentoring_id/components/features/HalamanPembahasan.dart';
import 'package:mentoring_id/constants/color_const.dart';

import 'class/Helpers.dart';
import 'components/DaftarKelasLangganan.dart';
import 'components/Splash.dart';
import 'components/features/Bejur.dart';
import 'components/features/HalamanPengerjaan/HalamanPengerjaanTO.dart';
import 'components/features/HistoryTryout.dart';
import 'components/features/NilaiTryout.dart';
import 'components/features/Rangkuman.dart';

// MENGGOKIL

void main() {
  runApp(MyApp());
}

API api;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Mentoring.id',
      theme: ThemeData(primaryColor: mPrimary, accentColor: mPrimary),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        final List<String> route = settings.name.split("/");
        final Args args = settings.arguments;
        Widget child = Home();

        Helpers.changeStatusBarColor();

        return PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation<double> animation, Animation<double> secondaryAnimation) {
          final scaleTransition =
              Tween<double>(begin: .9, end: 1).animate(animation);
          final bool isMobile = MediaQuery.of(context).size.width < 1024;

          if (route[1] == HalamanPengerjaanTO.route)
            child = HalamanPengerjaanTO(args: args);
          else if (route[1] == HistoryTryout.route)
            child = isMobile
                ? HistoryTryout.mobile(args)
                : HistoryTryout.desktop(args);
          else if (route[1] == NilaiTryout.route)
            child =
                isMobile ? NilaiTryout.mobile(args) : NilaiTryout.desktop(args);
          else if (route[1] == HalamanPembahasan.route)
            child = HalamanPembahasan(
              args: args,
            );
          else if (route[1] == Rangkuman.route && isMobile)
            child = Rangkuman.mobile(args);
          else if (route[1] == Bejur.route && isMobile)
            child = Bejur.mobile(args);
          else if (route[1] == DaftarKelasLangganan.route)
            child = DaftarKelasLangganan(
              args: args,
            );
          else if (route[1] == PendingInvoiceDesktop.route)
            child = Scaffold(
                body: SafeArea(
                    child: isMobile
                        ? PendingInvoiceMobile(api: args.api)
                        : PendingInvoiceDesktop(
                            api: args.api, closeable: true)));
          else if (route[1] == "login" && isMobile)
            child = Login(
              api: args.api,
              login: args.data,
            );

          if (isMobile) {
            final slideTransition =
                Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
                    CurvedAnimation(
                        parent: animation, curve: Curves.easeInOut));
            return SlideTransition(
              position: slideTransition,
              child: child,
            );
          }

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool splash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        splash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (api == null) api = API(context);
    double width = MediaQuery.of(context).size.width;

    Helpers.changeStatusBarColor();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    if (splash && api == null)
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "assets/img/icons/ic/medium.png",
            width: 80,
          ),
        ),
      );

    return FutureBuilder(
      future: api.init(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Disconnected(api: api);
        } else if (!snapshot.hasData) return Splash();

        return Scaffold(
            body: GestureDetector(
          onTapDown: (_) {
            FocusScope.of(context).unfocus();
          },
          child: Builder(builder: (context) {
            api.context = context;

            return ScreenAdapter(
              api: api,
              width: width,
            );
          }),
        ));
      },
    );
  }
}
