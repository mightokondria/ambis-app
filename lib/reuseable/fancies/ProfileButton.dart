import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class ProfileButton extends StatefulWidget {
  @override
  _ProfileButtonState createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton>
    with SingleTickerProviderStateMixin {
  double width = 150;
  bool toggle = true;
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 350),
    );
    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeIn, reverseCurve: Curves.easeOut);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45,
      child: Stack(
        children: [
          AnimatedContainer(duration: Duration(milliseconds: 370)),
          Clickable(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (toggle) {
                    toggle = !toggle;
                    controller.forward();
                  } else {
                    toggle = !toggle;
                    controller.reverse();
                  }
                });
              },
              child: Column(
                children: [
                  Flexible(
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 375),
                        width: toggle ? width * 0.85 : width * 0.88,
                        height: toggle ? 40 : 39.122,
                        curve: Curves.easeOut,
                        decoration: BoxDecoration(
                            color: mSecondaryYellowColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Syamsul",
                                style: TextStyle(
                                  color: mPrimary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(child: Icon(Icons.camera))
                          ],
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}