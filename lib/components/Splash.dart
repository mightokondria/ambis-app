import 'package:flutter/material.dart';
import 'package:mentoring_id/components/LoadingAnimation.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(child: LoadingAnimation.animation()));
  }
}
