
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ambis_app/constants/color_const.dart';

class NavElement extends StatelessWidget {

  final int selectedIndex;
  final Function onIndexChanged;

  NavElement(this.selectedIndex, this.onIndexChanged);


  @override
  Widget build(BuildContext context) {
    return Container(
      height:  400,

      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, top: 25),
            child: Text("Explore", style: TextStyle(fontSize: 21, color: Colors.indigo),),
          ),
          Divider(color: Colors.transparent,),
          //DASHBOARD
          Container(
            decoration: BoxDecoration(
              color: selectedIndex == 0 ? Colors.blue.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 40),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: selectedIndex == 0 ? Text("Dashboard", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Dashboard", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
              ),
              leading: selectedIndex == 0 ? Image.asset("assets/dashboard-on.png") : Image.asset("assets/dashboard-off.png"),
              onTap: () {
                onIndexChanged(0);
              },
            ),
          ),
          //  UPDATE
          Container(
            decoration: BoxDecoration(
              color: selectedIndex == 1 ? Colors.redAccent.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 40),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: selectedIndex == 1 ? Text("Update", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Update", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
              ),
              leading: selectedIndex == 1 ? Image.asset("assets/Update-on.png") : Image.asset("assets/Update-off.png"),
              onTap: () {
                onIndexChanged(1);
              },
            ),
          ),
          //  TRYOUT
          Container(
            decoration: BoxDecoration(
              color: selectedIndex == 2 ? Colors.yellow.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 40),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: selectedIndex == 2 ? Text("Tryout", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Tryout", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
              ),
              leading: selectedIndex == 2 ? Image.asset("assets/Tryout-on.png") : Image.asset("assets/tryout-off.png"),
              onTap: () {
                onIndexChanged(2);
              },
            ),
          ),
        ],
      ),
    );
  }
}


