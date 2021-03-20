import 'package:ambis_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:ambis_app/screen/home_screen.dart';

// MENGGOKIL

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ambis Kampus',
      home: HomeScreen(),
    );
  }
}
