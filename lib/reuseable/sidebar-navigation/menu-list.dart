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

    return Clickable(
      child: GestureDetector(
        onTap: () {
          onIndexChanged(index);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: active ? activeColor.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 40, top: 2, bottom: 2),
            title: Transform(
              transform: Matrix4.translationValues(-20, 0.0, 0.0),
              child: Text(title,
                  style: TextStyle(
                    fontSize: 14,
                    color: !active
                        ? Colors.grey[500]
                        : activeColor.withOpacity(.8),
                  )),
            ),
            leading: Image.asset("assets/img/navigation/" + icon + ".png",
                width: 18),
          ),
        ),
      ),
    );
  }
}
