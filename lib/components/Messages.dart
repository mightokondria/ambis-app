import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';

class Messages {
  static Widget message(
      {AssetImage image, String title, String content, Widget child}) {
    return Center(
      child: Column(
        children: [
          Image(
            image: image,
            width: 150,
          ),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: mHeadingText),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 200,
            child: Column(
              children: [
                Text(
                  content ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: mHeadingText.withOpacity(.3)),
                ),
                SizedBox(height: 20),
                child ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
