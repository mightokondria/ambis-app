import 'package:mentoring_id/reuseable/Banner.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/SearchBar.dart';
import 'package:mentoring_id/reuseable/TryoutList.dart';

class Tryout extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Tryout> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = [
      {
        "no_paket": "12",
        "nm_paket": "SAINTEK 8",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "13",
        "nm_paket": "SAINTEK 3",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "14",
        "nm_paket": "SAINTEK 2",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "15",
        "nm_paket": "SAINTEK 1",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "16",
        "nm_paket": "SAINTEK 7",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "17",
        "nm_paket": "SAINTEK 9",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "18",
        "nm_paket": "SAINTEK 5",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "19",
        "nm_paket": "SAINTEK 4",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "20",
        "nm_paket": "SAINTEK 6",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      },
      {
        "no_paket": "21",
        "nm_paket": "SAINTEK 10",
        "no_akun": "3",
        "xp": "30",
        "pub_start": null,
        "pub_end": null,
        "kategori": "SAINTEK"
      }
    ];

    return Column(children: [
      SizedBox(
        height: 20,
      ),
      SearchBar(),
      SizedBox(
        height: 20,
      ),
      ScreenBanner(),
      Container(
        transform: Matrix4.translationValues(0, -30, 0),
        child: Wrap(
          spacing: 10,
          children: [
            TryoutCategory(),
            TryoutCategory(),
            TryoutCategory(),
          ],
        )
      ),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: data.map((Map<String, String> e) {
          return TryoutList(e);
        }).toList(),
      )
    ]);
  }
}

class TryoutCategory extends StatelessWidget {
  const TryoutCategory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomCard.decoration(color: Colors.green),
      width: 200,
      height: 100,
    );
  }
}
