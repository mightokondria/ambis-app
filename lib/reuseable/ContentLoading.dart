import 'package:flutter/material.dart';

class ContentLoading extends StatefulWidget {
  final double width, height, radius;

  const ContentLoading(
      {Key key, this.width: double.infinity, this.height: 150, this.radius: 5})
      : super(key: key);

  @override
  _ContentLoadingState createState() => _ContentLoadingState();
}

class _ContentLoadingState extends State<ContentLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 1500), vsync: this)
          ..addListener(() {
            setState(() {});
          })
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Color(0xFFDDDDDD);
    final beginAnimation =
        Tween<double>(begin: -2.5, end: 5).animate(_controller);
    final endAnimation =
        Tween<double>(begin: -1, end: 7.5).animate(_controller);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          gradient: LinearGradient(
              begin: Alignment(beginAnimation.value, 0),
              end: Alignment(endAnimation.value, 0),
              colors: [
                dark,
                Color(0xFFEEEEEE),
                dark,
              ])),
    );
  }
}
