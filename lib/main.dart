import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/Device.dart';
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
        home: Builder(
          builder: (BuildContext context) {
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
                  api.initHandlers();
                  
                  return Device(
                    api: api,
                    width: width,
                  );
                }));
              },
            );
          },
        ),
      routes: {
          '/pengerjaan_to': (context) => halaman_pengerjaan_to()
      },
    );
  }
}
