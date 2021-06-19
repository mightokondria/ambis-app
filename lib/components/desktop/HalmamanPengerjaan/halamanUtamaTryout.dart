import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class HalamanUtamaTryout extends StatefulWidget {
  final Object data;

  const HalamanUtamaTryout({Key key, this.data}) : super(key: key);

  @override
  _HalamanUtamaTryoutState createState() => _HalamanUtamaTryoutState(data);
}

class _HalamanUtamaTryoutState extends State<HalamanUtamaTryout> {
  final Object data;

  _HalamanUtamaTryoutState(this.data);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isChecked = false;
    return Container(
      margin: EdgeInsets.only(top: 30),
      color: Colors.white,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: size.width * .65,
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac ex neque. Sed nec consectetur tellus. In tempor feugiat eros, a pulvinar felis pellentesque a.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Duis faucibus mauris nec semper consequat. Etiam dolor ante, condimentum a mollis ac, dictum et elit. Curabitur sodales elementum enim. Donec eu urna ornare, rutrum sapien at, aliquet erat. Nullam ut nisi sit amet velit lacinia accumsan quis non velit. Donec semper massa viverra augue tristique, blandit vehicula libero cursus. Sed facilisis iaculis eros."),
              SizedBox(
                height: 20,
              ),
              PilihanJawaban(),
              PilihanJawaban(
                selected: true,
              ),
              PilihanJawaban(),
              PilihanJawaban(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: size.height,
            child: Padding(
              padding: EdgeInsets.only(top: 30, right: 130, left: 50),
              child: TryoutIdentityWidget(
                data: data,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class PilihanJawaban extends StatelessWidget {
  PilihanJawaban({Key key, this.selected: false}) : super(key: key) {
    style = TextStyle(color: selected ? Colors.white : Color(0xFF555555));
  }

  final selected;
  TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Clickable(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: selected ? activeGreenColor : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: selected
                    ? null
                    : Border.all(
                        width: 2, color: Colors.black.withOpacity(.05))),
            child: Row(
              children: [
                Text(
                  "A",
                  style: style,
                ),
                SizedBox(width: 20),
                Text(
                  "Lorem ipsum des neges",
                  style: style,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}

class TryoutIdentityWidget extends StatefulWidget {
  final Object data;

  const TryoutIdentityWidget({Key key, this.data}) : super(key: key);

  @override
  _TryoutIdentityWidgetState createState() => _TryoutIdentityWidgetState(data);
}

class _TryoutIdentityWidgetState extends State<TryoutIdentityWidget> {
  final Object data;

  _TryoutIdentityWidgetState(this.data);

  BoxDecoration getTimerDecoration({bool active: false}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: !active ? Colors.black.withOpacity(.05) : activeGreenColor);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SAINTEK 3",
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        Text(
          "00:53:23",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        SizedBox(height: 20),
        Stack(
          children: [
            Container(
              decoration: getTimerDecoration(),
              width: double.infinity,
              height: 6,
            ),
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                height: 6,
                width: constraints.maxWidth * .99,
                decoration: getTimerDecoration(active: true),
              );
            }),
          ],
        ),
        SizedBox(height: 10),
        ListMateriTryout("SBMPTN"),
        SizedBox(height: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 230),
          child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              shrinkWrap: true,
              crossAxisCount: 5,
              children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                  .map((e) => Clickable(
                        child: Container(
                          decoration: BoxDecoration(
                              color: activeGreenColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: EdgeInsets.all(3),
                          child: Center(
                              child: Text(
                            e.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ))
                  .toList()),
        ),
        SizedBox(height: 20),
        CustomButton(
            value: "tutup",
            style: CustomButtonStyle(
                color: Colors.redAccent, textColor: Colors.white))
      ],
    );
  }
}

class ListMateriTryout extends StatelessWidget {
  // final API api;
  final String activeMateri;
  int active;
  List<String> materi;

  ListMateriTryout(this.activeMateri) {
    materi = ["SBMPTN", "TPS"];
    active = materi.indexOf(activeMateri);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    materi.asMap().forEach((key, value) {
      final bool isActive = key <= active;
      final Color textColor = isActive ? Colors.white : Color(0xFF555555);

      children.add(Container(
        constraints: BoxConstraints(minWidth: 100),
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
            color: isActive ? activeGreenColor : Colors.black.withOpacity(.05),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Materi",
              style: TextStyle(color: textColor.withOpacity(.6), fontSize: 10),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ));
    });

    return Container(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: children,
      ),
    );
  }
}
