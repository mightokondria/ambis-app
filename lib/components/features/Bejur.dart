import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Bejur.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/components/Messages.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Banner.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/FeatureHeader.dart';
import 'package:mentoring_id/reuseable/MicroIdentity.dart';
import 'package:mentoring_id/reuseable/SearchBar.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class Bejur {
  static String route = "bejur";
  static String description = "Tentukan jurusan tujuanmu mulai dari sekarang!";

  static Widget mobile(Args args) => _BejurWidget(args: args);
  static Widget desktop(Args args) => _BejurWidget(
        args: args,
        mobile: false,
      );
}

class _BejurWidget extends StatefulWidget {
  final Args args;
  final bool mobile;

  const _BejurWidget({Key key, this.args, this.mobile: true}) : super(key: key);

  @override
  __BejurWidgetState createState() => __BejurWidgetState();
}

class __BejurWidgetState extends State<_BejurWidget> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final api = widget.args.api;
    final data = widget.args.data as List<BejurModel>;

    Helpers.changeStatusBarColor(color: Colors.white);

    if (widget.mobile)
      return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                      alignment: Alignment.centerLeft,
                      color: Color(0xFF555555),
                      iconSize: 20,
                      onPressed: () => api.closeDialog(),
                      icon: Icon(Icons.arrow_back_ios)),
                ),
                FeatureHeader.mobile(
                    title: "Bedah jurusan",
                    description: Bejur.description,
                    illustration: "bedah-jurusan.png",
                    color: Colors.deepOrange),
                SizedBox(height: 10),
                mainBody(data, api),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ScreenBanner(
          title: "Bedah jurusan",
          description: Bejur.description,
          image: "bedah-jurusan.png",
          mainColor: Colors.deepOrange),
      SizedBox(
        height: 20,
      ),
      mainBody(data, api),
      SizedBox(
        height: 20,
      ),
    ]);
  }

  Widget mainBody(List<BejurModel> data, API api) {
    final listsData = data
        .where((element) =>
            element.jurusan.toLowerCase().indexOf(search.toLowerCase()) > -1)
        .toList();
    final mappedChildren =
        listsData.map((e) => BejurList(data: e, api: api)).toList();
    Widget lists;

    if (listsData.length < 1)
      lists = Column(
        children: [
          SizedBox(height: 30),
          Messages.message(
              image: AssetImage("assets/img/msg/404.png"),
              title: "Tidak ditemukan",
              content: "Jurusan dengan kata kunci '$search' tidak ditemukan.")
        ],
      );
    else if (widget.mobile)
      lists = GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          shrinkWrap: true,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          physics: NeverScrollableScrollPhysics(),
          children: mappedChildren);
    else
      lists = Wrap(spacing: 10, runSpacing: 10, children: mappedChildren);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.mobile ? 20 : 0, vertical: 10),
          child: Column(
            children: [
              SearchBar(
                placeholder: "Cari jurusan...",
                onSubmit: (val, empty) {
                  setState(() {
                    search = val;
                  });
                },
              ),
              SizedBox(height: 10),
              lists
            ],
          ),
        )
      ],
    );
  }
}

class BejurList extends StatelessWidget {
  final BejurModel data;
  final API api;

  const BejurList({
    Key key,
    this.data,
    this.api,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () => api.bejur.bedah(data),
      style: CustomButtonStyle.transparent(),
      padding: EdgeInsets.zero,
      fill: false,
      child: Container(
        width: 250,
        padding: EdgeInsets.all(15),
        decoration: CustomCard.decoration(radius: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.jurusan,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: mHeadingText,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                MicroIdentityForLists(
                  icon: Icon(Icons.visibility, size: 12, color: Colors.blue),
                  value: data.views,
                  textColor: Colors.blue,
                  backgroundColor: Colors.blue.withOpacity(.15),
                ),
                SizedBox(width: 5),
                MicroIdentityForLists(
                  icon:
                      SvgPicture.asset("assets/img/icons/hati.svg", width: 12),
                  value: data.cinta,
                  textColor: Colors.red,
                  backgroundColor: Colors.red.withOpacity(.15),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
