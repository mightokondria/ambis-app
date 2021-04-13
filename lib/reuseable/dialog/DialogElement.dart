import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';

import '../CustomCard.dart';

class DialogElement extends StatelessWidget {
  final API api;
  final Widget child;

  DialogElement({this.api, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      decoration: CustomCard.decoration(color: Color(0xFFF8f8f8)),
      constraints: api.parent.isDesktop ? BoxConstraints(maxWidth: 500) : null,
      child: child,
    );
  }
}
