import 'package:flutter/material.dart';
import 'package:mentoring_id/components/LoadingAnimation.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingAnimation.animation());
  }
}
