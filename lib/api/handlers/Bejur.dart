import 'package:flutter/material.dart';
import 'package:mentoring_id/api/models/Bejur.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/features/Bejur.dart';

import '../API.dart';

class BejurHandler {
  final API api;
  List<BejurModel> cache;

  BejurHandler(this.api);

  Future<List<BejurModel>> openBejur({bool mobile: true}) async {
    if (cache == null)
      await api
          .request(path: "jurusan/bedah_jurusan", animation: mobile)
          .then((value) {
        final data = api.safeDecoder(value.body) as List<dynamic>;
        cache = [];

        data.forEach((element) {
          cache.add(BejurModel(element));
        });
      });

    if (mobile)
      Navigator.pushNamed(api.context, "/${Bejur.route}",
          arguments: Args(api: api, data: cache));

    return cache;
  }

  bedah(BejurModel data) async {
    BejurModel result;

    await api.request(
        path: "jurusan/bedah",
        method: "POST",
        body: {"no_jurusan": data.noJurusan}).then((value) {
      data.views = (int.parse(data.views) + 1).toString();
      result = BejurModel(api.safeDecoder(value.body));
    });

    api.ui.showBejurDialog(result);
  }

  void refetch() {
    cache = null;
    openBejur(mobile: false);
  }

  void loveBejur(BejurModel data, bool loved) {
    api.request(
        path: "jurusan/love_bedah_jurusan",
        method: "POST",
        animation: false,
        body: {
          "no_jurusan": data.noJurusan,
          "value": loved ? 1 : 0
        }).then((value) {
      data.loved = loved;

      // REFRESH DATA
      refetch();
    });
  }
}
