import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Rangkuman.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/components/Messages.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Chip.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/FeatureHeader.dart';
import 'package:mentoring_id/reuseable/SearchBar.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

abstract class Rangkuman {
  static String route = "rangkuman";
  static String description = "Mantapkan persiapanmu menghadapi UTBK!";

  static Widget mobile(Args data) {
    return _RangkumanWidget(
      data: data,
    );
  }

  static List<Mapel> filter(List<Mapel> data, String filter) {
    return data
        .where((mapel) =>
            mapel.nmMapel.toLowerCase().indexOf(filter.toLowerCase()) > -1)
        .toList();
  }
}

class _RangkumanWidget extends StatefulWidget {
  final Args data;
  final bool mobile;

  const _RangkumanWidget({Key key, this.data, this.mobile: true})
      : super(key: key);

  @override
  _RangkumanWidgetState createState() => _RangkumanWidgetState();
}

class _RangkumanWidgetState extends State<_RangkumanWidget> {
  String filter;
  String category;

  @override
  Widget build(BuildContext context) {
    final api = widget.data.api;
    final all = "Semua";
    final List<Mapel> originalData = widget.data.data as List<Mapel>,
        data = originalData
            .where((e) =>
                category == null || category == all || e.nmMapel == category)
            .toList(),
        chipsData = [Mapel.chips("-", all)];

    // FORCE LIST CLONE
    originalData.forEach((element) => chipsData.add(element));

    final List<CustomChip> chips = chipsData
        .map((e) => CustomChip(value: e.nmMapel, selected: e.nmMapel == all))
        .toList();

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
                    title: "Rangkuman",
                    description: Rangkuman.description,
                    illustration: "rangkuman.png",
                    color: Colors.green),
                SizedBox(height: 10),
                mainBody(chips, data, api),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );

    return Container();
  }

  Widget mainBody(List<CustomChip> chips, List<Mapel> data, API api) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SearchBar(
                placeholder: "Cari rangkuman",
                onSubmit: (val, empty) {
                  setState(() {
                    filter = val;
                  });
                },
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ChipGroup(
            allowMultipleSelection: false,
            onChange: (chips) {
              setState(() {
                category = chips[0].value;
              });
            },
            chips: chips,
          ),
        ),
        SizedBox(height: 10),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .map((e) => MapelList(
                    api: api,
                    mapel: e,
                    filter: filter,
                    showTitle: data.length > 1,
                    mobile: widget.mobile))
                .toList()),
      ],
    );
  }
}

class MapelList extends StatelessWidget {
  final Mapel mapel;
  final API api;
  final bool showTitle, mobile;
  final String filter;

  const MapelList({
    Key key,
    @required this.api,
    @required this.mapel,
    this.showTitle: true,
    this.filter,
    this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rangkuman = mapel.rangkuman.where((e) =>
        filter == null ||
        filter.isEmpty ||
        e.judulMateri.toLowerCase().indexOf(filter.toLowerCase()) > -1);
    Widget rangkumanLists;

    if (rangkuman.isEmpty && !showTitle)
      return Column(
        children: [
          SizedBox(height: 30),
          Messages.message(
              image: AssetImage("assets/img/msg/404.png"),
              title: "Tidak ditemukan",
              content:
                  "Rangkuman materi dengan kueri pencarian '$filter' tidak ditemukan di mapel ini"),
        ],
      );
    else if (rangkuman.isEmpty) return SizedBox();

    if (mobile)
      rangkumanLists = SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            children: rangkuman
                .map((e) => Row(
                      children: [
                        RangkumanList(data: e, api: api),
                        SizedBox(width: 10),
                      ],
                    ))
                .toList(),
          ),
        ),
      );
    else
      rangkumanLists = Wrap(
        spacing: 10,
        runSpacing: 10,
        children:
            rangkuman.map((e) => RangkumanList(data: e, api: api)).toList(),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showTitle
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  mapel.nmMapel,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF555555)),
                ),
              )
            : SizedBox(),
        Align(alignment: Alignment.centerLeft, child: rangkumanLists),
        SizedBox(height: 15),
      ],
    );
  }
}

class RangkumanList extends StatelessWidget {
  final RangkumanModel data;
  final API api;

  const RangkumanList({
    Key key,
    this.data,
    this.api,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = 250.0;

    return CustomButton(
      onTap: () => api.rangkuman.downloadRangkuman(data.noMateri),
      fill: false,
      style: CustomButtonStyle.transparent(),
      padding: EdgeInsets.zero,
      child: Container(
        decoration: CustomCard.decoration(radius: 15),
        padding: EdgeInsets.all(25),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.judulMateri,
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
                  icon:
                      SvgPicture.asset("assets/img/icons/file.svg", width: 12),
                  value: data.size,
                  textColor: mPrimary,
                  backgroundColor: mSemiPrimary,
                ),
                SizedBox(width: 5),
                MicroIdentityForLists(
                  icon: SvgPicture.asset("assets/img/icons/download.svg",
                      width: 12),
                  value: data.downloads,
                  textColor: Colors.green,
                  backgroundColor: Colors.green.withOpacity(.15),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MicroIdentityForLists extends StatelessWidget {
  final Color backgroundColor, textColor;
  final Widget icon;
  final String value;

  const MicroIdentityForLists(
      {Key key,
      this.backgroundColor: Colors.transparent,
      this.textColor: const Color(0xFF555555),
      @required this.icon,
      @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(children: [
              icon,
              SizedBox(width: 10),
              Text(value,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12))
            ]))
      ],
    );
  }
}
