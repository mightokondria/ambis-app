import 'package:flutter/material.dart';

class ScreenBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 280,
      width: double.infinity,
      child: Positioned(
        bottom: 80,
        child: Container(
          padding:
              EdgeInsets.only(left: 50, right: 20, top: 30, bottom: 30),
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
    );
  }
}
