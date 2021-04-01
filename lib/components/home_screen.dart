
import 'package:ambis_app/components/desktop/navigation/AppBarCustombyMe.dart';
import 'package:ambis_app/components/desktop/navigation/side_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'desktop/navigation/AppBarCustombyMe.dart';

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
