
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/desktop/Desktop.dart';
import 'package:mentoring_id/components/mobile/Mobile.dart';
import 'package:flutter/material.dart';

class Device extends StatelessWidget  {

  final API api;

  Device(this.api);

  @override
  Widget build(BuildContext context) {
    int desktopResolution = 768;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= desktopResolution;

    return isDesktop? Desktop(api) : Mobile(api);
  }
}
