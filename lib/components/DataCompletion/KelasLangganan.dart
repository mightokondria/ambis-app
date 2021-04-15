import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/reuseable/KelasLanggananList.dart';

class KelasLangganan extends StatelessWidget {
  final API api;
  final List<KelasLanggananModel> kelases;

  const KelasLangganan({Key key, this.api, this.kelases}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: kelases
          .map((e) => KelasLanggananList(
                data: e,
              ))
          .toList(),
    ));
  }
}
