import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class ProfileButton extends StatefulWidget {
  final API api;
  final Function toggler;

  const ProfileButton({Key key, this.api, this.toggler}) : super(key: key);

  @override
  _ProfileButtonState createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Clickable(
      child: GestureDetector(
        onTap: widget.toggler,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: mSemiPrimary),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hi, " + widget.api.data.nama.split(" ")[0] + "!",
                style: TextStyle(color: mPrimary),
              ),
              SizedBox(width: 10),
              SvgPicture.asset(
                "assets/img/icons/profile.svg",
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
