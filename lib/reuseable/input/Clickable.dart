import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Clickable extends StatelessWidget {
  final Widget child;

  Clickable({this.child});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(cursor: SystemMouseCursors.click, child: child);
  }
}
