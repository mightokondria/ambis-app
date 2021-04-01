import 'dart:ui';
import 'package:ambis_app/reuseable/sidebar-navigation/menu-list.dart';
import 'package:ambis_app/screen/side_navigation_bar.dart';
import 'package:ambis_app/screen/AppBarCustombyMe.dart';
import 'package:ambis_app/screen/side_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'AppBarCustombyMe.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustombyMe(),
      body: SideNavigationBar(),
    );
  }
}
