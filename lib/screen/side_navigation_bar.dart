import 'package:ambis_app/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideNavigationBar extends StatefulWidget {
  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  final List<String> menuItems = ["Dashboard", "Update", "Tryout"];
  final List<String> menuIcons = [
    "assets/dashboard-off.png",
    "assets/Update-off.png",
    "assets/tryout-off.png"
  ];
  int _selectedIndex = 0;
  var _textstyle = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  // void _onItemTapped(int index){
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            color: mGreyColor,
            height: MediaQuery.of(context).size.height,
            width: 300.0,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Expanded(
                          child: new ListView.builder(
                              itemCount: menuItems.length,
                              itemBuilder: (context, index) => Container(
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 25,
                                                  top: 10,
                                                  bottom: 10,
                                                  right: 10),
                                              child: Image.asset(
                                                menuIcons[index],
                                                width: 15.5,
                                              )),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 0.0,
                                                top: 0,
                                                right: 8,
                                                bottom: 0),
                                            child: Text(
                                              menuItems[index],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
