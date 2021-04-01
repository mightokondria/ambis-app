import 'package:ambis_app/components/home_screen.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: HomeScreen(),
    );
  }
}
