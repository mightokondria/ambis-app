
import 'package:mentoring_id/components/desktop/navigation/AppBarCustombyMe.dart';
import 'package:mentoring_id/components/desktop/navigation/side_navigation_bar.dart';
import 'package:mentoring_id/components/mobile/Body.dart';
import 'package:flutter/material.dart';

import 'desktop/navigation/AppBarCustombyMe.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    int desktopResolution = 768;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= desktopResolution;

    // THIS IS FOR DESKTOP
    if(isDesktop)
      return Scaffold(
        appBar: AppBarCustombyMe(),
        body: SideNavigationBar(),
      );

    return Scaffold(
      body: MobileBody(),
    );
  }
}