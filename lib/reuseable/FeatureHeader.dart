import 'package:flutter/material.dart';

abstract class FeatureHeader {
  static Widget mobile(
          {@required String title,
          @required String description,
          @required String illustration,
          Color color: Colors.pink}) =>
      _MobileFeatureHeader(
        title: title,
        description: description,
        illustration: illustration,
        mainColor: color,
      );
}

class _MobileFeatureHeader extends StatelessWidget {
  final String illustration, title, description;
  final Color mainColor;

  const _MobileFeatureHeader({
    Key key,
    this.illustration,
    this.title,
    this.description,
    this.mainColor: Colors.pink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(150))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/img/msg/$illustration",
            width: 150,
          ),
          SizedBox(height: 30),
          Text(title,
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: TextStyle(color: Color(0xFF888888), fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
