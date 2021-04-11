import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/desktop/Desktop.dart';
import 'package:mentoring_id/components/mobile/Mobile.dart';

import 'Disconnected.dart';

class Device extends StatefulWidget {
  final API api;
  final double width;

  const Device({Key key, this.api, this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DeviceState(api, width);
}

class DeviceState extends State<Device> {
  final API api;
  final int desktopResolution = 768;

  /*
  * INDEXES DETAIL
  * 0 : INITIAL HOMEPAGE
  * 1 : ERROR DISCONNECTED
  * 2 : REFRESH HOMEPAGE
  * 3 : SHOW LOADING ANIMATION
  */
  int index = 0;
  Widget devices;
  double width;
  bool isDesktop;

  DeviceState(this.api, this.width);

  @override
  void initState() {
    this.devices = home();
  }

  Widget home() {
    isDesktop = width >= desktopResolution;
    return isDesktop ? Desktop(api) : Mobile(api);
  }

  changeIndex(int i) => setState(() {
        index = i;
      });

  @override
  Widget build(BuildContext context) {
    api.parent = this;
    
    return IndexedStack(index: index, children: [
      home(),
      Disconnected(api: api,),
    ]);
  }
}
