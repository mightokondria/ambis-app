// FINALLY LAST FEATURE TO WORK ON😁💪

import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Ingfo.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class Ingfo extends StatefulWidget {
  final bool mobile;
  final API api;

  Ingfo({Key key, this.mobile, this.api}) : super(key: key);

  @override
  _IngfoState createState() => _IngfoState();
}

class _IngfoState extends State<Ingfo> {
  @override
  Widget build(BuildContext context) {
    final api = widget.api;
    final data = api.ingfo.cache;

    if (widget.mobile)
      return RefreshIndicator(
        onRefresh: api.ingfo.fetch,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: data
                    .map((e) => Column(children: [
                          IngfoList(api: api, data: e, mobile: true),
                          SizedBox(
                            height: 10,
                          ),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ),
      );

    return LayoutBuilder(builder: (context, constraints) {
      final widthEachTile = (constraints.maxWidth / 3) - 20;

      return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: data
                .map((e) => IngfoList(
                      api: api,
                      data: e,
                      mobile: false,
                      width: widthEachTile,
                    ))
                .toList()),
      );
    });
  }
}

class IngfoList extends StatelessWidget {
  final API api;
  final IngfoModel data;
  final bool mobile;
  final double width;

  const IngfoList({
    Key key,
    this.api,
    this.data,
    this.mobile,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      style: CustomButtonStyle.transparent(),
      fill: false,
      padding: EdgeInsets.zero,
      onTap: () => api.ingfo.open(data),
      child: Container(
        constraints: mobile
            ? BoxConstraints()
            : BoxConstraints(
                maxWidth: width,
              ),
        decoration: CustomCard.decoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(api.defaultAPI +
                              "files/informasi/img.php?image=" +
                              data.cover),
                          fit: BoxFit.cover))),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.judul,
                      style: TextStyle(
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Sumber: ${data.sumber}",
                      style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
