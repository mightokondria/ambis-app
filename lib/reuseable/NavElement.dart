
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavElement extends StatelessWidget {

  final int selectedIndex;
  final Function onIndexChanged;

  NavElement(this.selectedIndex, this.onIndexChanged);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height:  MediaQuery.of(context).size.height,

        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: Text("Explore", style: TextStyle(fontSize: 21, color: Colors.indigo,fontWeight: FontWeight.bold),),
            ),
            Divider(color: Colors.transparent,),
            //DASHBOARD == 0
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
            //  UPDATE == 1
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
            //  TRYOUT == 2
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
            Divider(color: Colors.transparent,),
            Divider(color: Colors.transparent,),
          //  HISTORY TRYOUT == 3
            Container(
              decoration: BoxDecoration(
                color: selectedIndex == 3 ? Colors.green.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: selectedIndex == 3 ? Text("Histori Tryout", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Tryout", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
                ),
                leading: selectedIndex == 3 ? Image.asset("assets/icons/histori-tryout-on.png") : Image.asset("assets/icons/histori-tryout-off.png"),
                onTap: () {
                  onIndexChanged(3);
                },
              ),
            ),
          //  RANGKUMAN == 4
            Container(
              decoration: BoxDecoration(
                color: selectedIndex == 4 ? Colors.redAccent.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: selectedIndex == 4 ? Text("Rangkuman", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Rangkuman", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
                ),
                leading: selectedIndex == 4 ? Image.asset("assets/icons/rangkuman-on.png") : Image.asset("assets/icons/rangkuman-off.png"),
                onTap: () {
                  onIndexChanged(4);
                },
              ),
            ),
          //  BEDAH JURUSAN == 5
            Container(
              decoration: BoxDecoration(
                color: selectedIndex == 5 ? Colors.blue.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: selectedIndex == 5 ? Text("Bedah Jurusan", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Bedah Jurusan", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
                ),
                leading: selectedIndex == 5 ? Image.asset("assets/icons/bejur-on.png") : Image.asset("assets/icons/bejur-off.png"),
                onTap: () {
                  onIndexChanged(5);
                },
              ),
            ),
            Divider(color: Colors.transparent,),
            Divider(color: Colors.transparent,),
            //PENGATURAN == 6
            Container(
              decoration: BoxDecoration(
                color: selectedIndex == 6 ? Colors.yellow.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: selectedIndex == 6 ? Text("Pengaturan", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Pengaturan", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
                ),
                leading: selectedIndex == 6 ? Image.asset("assets/settings-on.png") : Image.asset("assets/settings-off.png"),
                onTap: () {
                  onIndexChanged(6);
                },
              ),
            ),
            //FEEDBACK == 7
            Container(
              decoration: BoxDecoration(
                color: selectedIndex == 7 ? Colors.yellow.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: selectedIndex == 7 ? Text("Feedback", style: TextStyle(fontSize: 14,color: Colors.grey[500],letterSpacing: 2.0)) : Text("Feedback", style: TextStyle(fontSize: 14,color: Colors.grey[600])),
                ),
                leading: selectedIndex == 7 ? Image.asset("assets/feedback-on.png") : Image.asset("assets/feedback-off.png"),
                onTap: () {
                  onIndexChanged(7);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


