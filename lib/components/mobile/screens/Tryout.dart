import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/api/handlers/Tryout.dart';
import 'package:mentoring_id/api/models/Kategori.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/SearchBar.dart';
import 'package:mentoring_id/reuseable/TryoutList.dart';

class TryoutDataScreen extends StatefulWidget {
  final API api;

  const TryoutDataScreen(this.api, {Key key}) : super(key: key);

  @override
  _TryoutDataScreenState createState() => _TryoutDataScreenState(api);
}

class _TryoutDataScreenState extends State<TryoutDataScreen> {
  final API api;
  final EdgeInsetsGeometry horizontalContentPadding =
      EdgeInsets.symmetric(horizontal: 20);

  _TryoutDataScreenState(this.api);

  List<Kategori> data = [], searchResult = [];
  String selected = TryoutHandler.defaultKategori;

  @override
  void initState() {
    super.initState();
    api.tryout.getTryoutData().then((value) => setState(() {
          data = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    Helpers.changeStatusBarColor(color: Colors.white);

    final List<String> cats = TryoutHandler.kategori;
    final List<List<TryoutList>> widgets = cats.map((e) {
      List<TryoutList> children = [];

      (searchResult.isEmpty ? data : searchResult).forEach((val) {
        if (val.nmKategori.toLowerCase() == e.toLowerCase())
          children = val.tryout.map((e) => TryoutList(e, api)).toList();
      });

      return children;
    }).toList();

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MobileTryoutHeader(),
              SizedBox(height: 20),
              Padding(
                padding: horizontalContentPadding,
                child: SearchBar(
                  placeholder: "Cari tryout...",
                  onSubmit: (val, empty) {
                    setState(() {
                      data = api.tryout.filter(val);
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MobileTryoutCategory(
                        parent: this, category: cats[0], children: widgets[0]),
                    MobileTryoutCategory(
                        parent: this, category: cats[1], children: widgets[1]),
                    MobileTryoutCategory(
                        parent: this, category: cats[2], children: widgets[2]),
                  ],
                ),
              ),
              MobileTryoutCategory(
                  parent: this, category: cats[3], children: widgets[3]),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileTryoutCategory extends StatelessWidget {
  const MobileTryoutCategory({
    Key key,
    @required this.children,
    @required this.category,
    this.parent,
  }) : super(key: key);

  final List<Widget> children;
  final String category;
  final _TryoutDataScreenState parent;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: parent.horizontalContentPadding,
          child: Text(
            category,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: mHeadingText),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: parent.horizontalContentPadding,
            child: Wrap(spacing: 10, children: children),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class MobileTryoutHeader extends StatelessWidget {
  const MobileTryoutHeader({
    Key key,
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
        children: [
          Image.asset(
            "assets/img/msg/tryout-icon.png",
            width: 150,
          ),
          SizedBox(height: 30),
          Text("Tryout",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          SizedBox(
            height: 5,
          ),
          Text(
            "Yuk kerjain tryout!",
            style: TextStyle(color: Color(0xFF888888), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
