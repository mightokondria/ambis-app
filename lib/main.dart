import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/Device.dart';
import 'package:mentoring_id/components/Disconnected.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';

import 'components/Splash.dart';

// MENGGOKIL

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API api = API();

    return MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Mentoring.id',
        theme: ThemeData(fontFamily: 'OpenSans'),
        home: Builder(
          builder: (BuildContext context) {
            double width = MediaQuery.of(context).size.width;
            
            return FutureBuilder(
              future: api.init(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Disconnected();
                else if (!snapshot.hasData) return Splash();

                return Device(
                  api: api,
                  width: width,
                );
              },
            );
          },
        ));
  }
}
