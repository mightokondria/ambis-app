import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class XPbar extends StatefulWidget {
  @override
  _XPbarState createState() => _XPbarState();
}

class _XPbarState extends State<XPbar> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 100.0,
        child: StepProgressIndicator(
          totalSteps: 100,
          currentStep: 69,
          size: 8,
          padding: 0,
          selectedColor: mSecondaryRedColor,
          unselectedColor: Colors.white,
          roundedEdges: Radius.circular(50),
        ),
      ),
    );
  }
}
