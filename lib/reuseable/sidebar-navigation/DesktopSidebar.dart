import 'package:ambis_app/constants/color_const.dart';
import 'package:ambis_app/reuseable/sidebar-navigation/menu-list.dart';
import 'package:flutter/material.dart';

class DesktopSidebar extends StatelessWidget {

  final int selectedIndex;
  final Function onIndexChanged;
  final double sectionSpace = 15;

  DesktopSidebar(this.selectedIndex, this.onIndexChanged);

  @override
  Widget build(BuildContext context) {
    SidebarMenuList menuList = SidebarMenuList(selectedIndex, onIndexChanged);

    return Container(
      child: Column(
        children: [
          menuList.sidebarMenuList(title: "Dashboard", activeColor: Colors.red, index: 0),
          menuList.sidebarMenuList(title: "Update", activeColor: Colors.blue, index: 1),
          menuList.sidebarMenuList(title: "Tryout", activeColor: Colors.orange, index: 2),

          // SPACER FOR SECTION
          SizedBox(height: sectionSpace,),

          menuList.sidebarMenuList(title: "History tryout", activeColor: featureColors["history"], index: 3),
          menuList.sidebarMenuList(title: "Rangkuman", activeColor: featureColors["rangkuman"], index: 4),
          menuList.sidebarMenuList(title: "Bedah jurusan", activeColor: featureColors["bejur"], index: 5),
          
          SizedBox(height: sectionSpace,),

          menuList.sidebarMenuList(title: "Settings", activeColor: Colors.blue, index: 6),
          menuList.sidebarMenuList(title: "Feedback", activeColor: Colors.orange, index: 7),

          SizedBox(height: sectionSpace,),
        ],
      ),
    );
  }
}