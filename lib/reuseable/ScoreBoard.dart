import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final String title, score;
  final Color textColor;

  const ScoreBoard({
    Key key,
    this.title,
    this.score,
    this.textColor: Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(color: textColor.withOpacity(.7), fontSize: 12)),
          Text(
            score,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 36),
          )
        ],
      ),
    );
  }
}
