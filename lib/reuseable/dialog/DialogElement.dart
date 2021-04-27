import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';

import '../CustomCard.dart';

class DialogElement extends StatelessWidget {
  final API api;
  final Widget child;
  final bool responsive;

  DialogElement({this.api, this.child, this.responsive: true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (responsive && api.parent.isDesktop)
          ? EdgeInsets.symmetric(vertical: 30, horizontal: 50)
          : EdgeInsets.all(30),
      decoration: CustomCard.decoration(color: Color(0xFFF9F9F9)),
      constraints: api.parent.isDesktop ? BoxConstraints(maxWidth: 500) : null,
      child: child,
    );
  }
}
