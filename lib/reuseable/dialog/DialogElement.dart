import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';

import '../CustomCard.dart';

class DialogElement extends StatelessWidget {
  final API api;
  final Widget child;
  final bool responsive;
  final Color color;
  final double horizontalDesktopPadding;

  DialogElement(
      {this.api,
      this.child,
      this.color: const Color(0xFFF9F9F9),
      this.responsive: true,
      this.horizontalDesktopPadding: 50.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (responsive && api.screenAdapter.isDesktop)
          ? EdgeInsets.symmetric(
              vertical: 30, horizontal: horizontalDesktopPadding)
          : EdgeInsets.all(30),
      decoration: CustomCard.decoration(color: color),
      constraints:
          api.screenAdapter.isDesktop ? BoxConstraints(maxWidth: 500) : null,
      child: child,
    );
  }
}
