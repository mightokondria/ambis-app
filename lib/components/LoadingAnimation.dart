import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  static Widget animation() {
    // return Image.asset("assets/img/animation/mentoring-loading.gif", width: 50);
    return LottieBuilder.asset("assets/img/animation/mentoring-loading.json",
        repeat: true, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Container(
          height: 70,
          width: 100,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(child: LoadingAnimation.animation()),
        ),
      ),
    );
  }
}
