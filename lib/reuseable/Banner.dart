import 'package:flutter/material.dart';

class ScreenBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: 50, right: 20, top: 30, bottom: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06), 
            offset: Offset(1, 3),
            blurRadius: 8,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tryout"),
              Text("Yuk kerjain tryout"),
            ],
          ),
          Image.asset("assets/img/msg/tryout.png", width: 250,)
        ],
      )
    );
  }
}