import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';

class Steps extends StatelessWidget {
  final List<String> items;
  final int activeIndex;
  Color activeColor = mPrimary;

  Steps({this.items, this.activeIndex: 0});

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.all(Radius.circular(10));
    double height = 8;
    List<Widget> mappedItems = [];

    return LayoutBuilder(builder: (context, boxConstraints) {
      double width = boxConstraints.maxWidth;

      items.asMap().forEach((index, text) {
        bool active = activeIndex >= index;
        mappedItems.add(Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topCenter,
              width: (width / items.length) - 20,
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
              width: (width * ((activeIndex + 1) / items.length)) -
                  ((activeIndex != items.length - 1)
                      ? ((width / items.length) / 2) // WIDTH OF EACH ITEM
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
