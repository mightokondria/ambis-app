import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/components/features/Info.dart';
import 'package:mentoring_id/components/mobile/screens/Dashboard.dart';
import 'package:mentoring_id/components/mobile/screens/Saya.dart';
import 'package:mentoring_id/components/mobile/screens/Tryout.dart';
import 'package:mentoring_id/constants/color_const.dart';

class Home extends StatefulWidget {
  final API api;

  Home(this.api);
  @override
  _HomeState createState() => _HomeState(api);
}

class _HomeState extends State<Home> {
  final API api;
  int activeIndex = 1;

  _HomeState(this.api);

  changeActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFFF5F5F5);
    List<Widget> child = [
      Dashboard(api: api),
      Ingfo(mobile: true, api: api),
      TryoutDataScreen(api),
      Saya(
        api: api,
      ),
    ];
    api.screenChanger = changeActiveIndex;

    Helpers.changeStatusBarColor();

    return Container(
      color: color,
      child: Column(
        children: [
          Expanded(
            child: child[activeIndex - 1],
          ),
          CustomBottomNavigation(
              activeIndex: activeIndex, changeActiveIndex: changeActiveIndex),
        ],
      ),
    );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  final upperRadius = Radius.circular(10);
  final int activeIndex;
  final void Function(int index) changeActiveIndex;

  CustomBottomNavigation({Key key, this.activeIndex, this.changeActiveIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomBottomNavigationItem itemAdapter =
        CustomBottomNavigationItem(activeIndex, changeActiveIndex);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 8)
        ],
        borderRadius:
            BorderRadius.only(topLeft: upperRadius, topRight: upperRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          itemAdapter.addItem(
            icon: "home",
            label: "Dasboard",
          ),
          itemAdapter.addItem(
            icon: "ingfo",
            label: "Update",
          ),
          itemAdapter.addItem(
            icon: "tryout",
            label: "Tryout",
          ),
          itemAdapter.addItem(
            icon: "profile",
            label: "Saya",
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final int activeIndex;
  final void Function(int index) changer;
  int index = 0;

  CustomBottomNavigationItem(this.activeIndex, this.changer);

  addItem({@required String icon, @required String label}) {
    index++;
    final target = index;

    return InkWell(
      onTap: () {
        changer(target);
      },
      child: CustomBottomNavigationItemElement(
        icon: icon,
        label: label,
        active: index == activeIndex,
      ),
    );
  }
}

class CustomBottomNavigationItemElement extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;
  final int index;

  const CustomBottomNavigationItemElement(
      {Key key,
      @required this.icon,
      @required this.label,
      this.active,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconFile = (active ? "active" : "off") + "-$icon.png";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/img/mobile/navigation/$iconFile",
            width: 20,
          ),
          SizedBox(height: 10),
          Text(label,
              style: TextStyle(
                  fontSize: 10, color: active ? mPrimary : Colors.black38)),
        ],
      ),
    );
  }
}
