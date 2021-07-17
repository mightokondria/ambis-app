import 'package:flutter/material.dart';
import 'package:mentoring_id/components/features/Bejur.dart';

class ScreenBanner extends StatelessWidget {
  final String title, description, image;
  final Color mainColor;

  const ScreenBanner(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.image,
      this.mainColor: Colors.pink})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 20, top: 30, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              offset: Offset(1, 3),
              blurRadius: 8,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    Bejur.description,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            Flexible(
                child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      "assets/img/msg/$image",
                      width: 250,
                    ))),
          ],
        ),
      ),
    );
  }
}
