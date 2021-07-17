import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class DesktopCloseButton extends StatelessWidget {
  final bool white;

  const DesktopCloseButton({Key key, @required this.api, this.white: false})
      : super(key: key);

  final API api;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      style: CustomButtonStyle.transparent(),
      padding: EdgeInsets.zero,
      fill: false,
      onTap: api.closeDialog,
      child: ClipOval(
          child: Container(
              color: white ? Colors.white : Colors.red,
              padding: EdgeInsets.all(5),
              child: Icon(Icons.close,
                  color: white ? Colors.red : Colors.white, size: 15))),
    );
  }
}
