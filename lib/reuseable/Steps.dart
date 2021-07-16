import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';

class Steps extends StatefulWidget {
  final List<String> items;
  final int activeIndex;

  Steps({this.items, this.activeIndex: 0});

  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  Color activeColor = mPrimary;

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.all(Radius.circular(10));
    double height = 8;
    List<Widget> mappedItems = [];

    return LayoutBuilder(builder: (context, boxConstraints) {
      double width = boxConstraints.maxWidth;

      widget.items.asMap().forEach((index, text) {
        bool active = widget.activeIndex >= index;
        mappedItems.add(Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topCenter,
              width: (width / widget.items.length) - 20,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: active ? activeColor : Color(0xFF888888)),
              ),
            )
          ],
        ));
      });

      return Container(
        child: Stack(
          children: [
            Container(
              width: width,
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: radius),
              height: height,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutCirc,
              height: height,
              width:
                  (width * ((widget.activeIndex + 1) / widget.items.length)) -
                      ((widget.activeIndex != widget.items.length - 1)
                          ? ((width / widget.items.length) /
                              2) // WIDTH OF EACH ITEM
                          : 0),
              decoration: BoxDecoration(color: mPrimary, borderRadius: radius),
            ),
            Container(
              transform: Matrix4.translationValues(0, -4, 0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: mappedItems,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
