import 'package:flutter/material.dart';

class ScreenBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 380,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 80,
            child: Container(
              padding:
                  EdgeInsets.only(left: 50, right: 20, top: 30, bottom: 30),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    offset: Offset(1, 3),
                    blurRadius: 8,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              constraints: BoxConstraints(maxWidth: 700, maxHeight: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tryout",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 40,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "Yuk kerjain tryout",
                          style: TextStyle(
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Image.asset(
                            "assets/img/msg/tryout-icon.png",
                            width: 250,
                          ))),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  height: 84,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  height: 84,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  height: 84,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
