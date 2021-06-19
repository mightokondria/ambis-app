import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/handlers/Tryout.dart';
import 'package:mentoring_id/api/models/Kategori.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/components/LoadingAnimation.dart';
import 'package:mentoring_id/components/Messages.dart';
import 'package:mentoring_id/reuseable/Banner.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/Chip.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/SearchBar.dart';
import 'package:mentoring_id/reuseable/TryoutList.dart';

class TryoutDataScreen extends StatefulWidget {
  final API api;

  const TryoutDataScreen({Key key, this.api}) : super(key: key);

  @override
  _TryoutDataScreenState createState() => _TryoutDataScreenState(api);
}

class _TryoutDataScreenState extends State<TryoutDataScreen> {
  final API api;

  List<Tryout> dataTryout;
  List<Kategori> searchResult;
  String kategori = TryoutHandler.defaultKategori;

  _TryoutDataScreenState(this.api);

  @override
  Widget build(BuildContext context) {
    if (dataTryout == null)
      api.tryout.getTryoutData().then((value) {
        setState(() {
          dataTryout = api.tryout.filterWithKategori(kategori)[0].tryout;
        });
      });

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      ScreenBanner(),
      SizedBox(
        height: 20,
      ),
      SearchBar(
        placeholder: "Cari tryout...",
        onSubmit: (val, empty) {
          setState(() {
            searchResult = api.tryout.filter(val);
            dataTryout = api.tryout
                .filterWithKategori(kategori,
                    data: empty ? null : searchResult)[0]
                .tryout;
          });
        },
      ),
      SizedBox(
        height: 20,
      ),
      ChipGroup(
        allowMultipleSelection: false,
        chips: TryoutHandler.kategori
            .map((e) => CustomChip(value: e, selected: e == kategori))
            .toList(),
        onChange: (v) {
          kategori = v[0].value;
          setState(() {
            dataTryout = api.tryout
                .filterWithKategori(kategori, data: searchResult)[0]
                .tryout;
          });
        },
      ),
      SizedBox(
        height: 20,
      ),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: (dataTryout == null)
            ? [Center(child: LoadingAnimation.animation())]
            : (dataTryout.isNotEmpty)
                ? dataTryout.map((e) => TryoutList(e, api)).toList()
                : [
                    TryoutHandler.notFoundMessage,
                  ],
      ),
      SizedBox(
        height: 20,
      ),
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
