import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class SidebarMenuList {
  final int selectedIndex;
  final Function onIndexChanged;

  SidebarMenuList(this.selectedIndex, this.onIndexChanged);

  Widget sidebarMenuList(
      {String title, Color activeColor: Colors.blue, int index}) {
    bool active = selectedIndex == index;
    String icon = title.toLowerCase().replaceAll(" ", "-") + "-on";

    return GestureDetector(
      onTap: () {
        onIndexChanged(index);
      },
      child: Clickable(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: active ? activeColor.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: Row(
            children: [
              SizedBox(width: 20),
              Image.asset("assets/img/navigation/" + icon + ".png", width: 18),
              SizedBox(width: 10),
              Text(title,
                  style: TextStyle(
                    fontSize: 14,
                    color: !active
                        ? Colors.grey[500]
                        : activeColor.withOpacity(.8),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
