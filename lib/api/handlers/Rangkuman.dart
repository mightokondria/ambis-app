import 'package:flutter/cupertino.dart';
import 'package:mentoring_id/api/models/Rangkuman.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/features/Rangkuman.dart';
import 'package:url_launcher/url_launcher.dart';

import '../API.dart';

class RangkumanHandler {
  final API api;
  List<Mapel> cache;

  RangkumanHandler(this.api);

  Future<void> getRangkumanList({bool mobile: true}) async {
    if (cache == null) {
      cache = [];
      await api
          .request(path: "rangkuman/result", animation: mobile)
          .then((res) {
        final List<dynamic> data = api.safeDecoder(res.body);

        data.forEach((element) {
          cache.add(Mapel(element));
        });
      });
    }

    if (mobile)
      Navigator.pushNamed(api.context, "/${Rangkuman.route}",
          arguments: Args(api: api, data: cache));
  }

  downloadRangkuman(RangkumanModel materi) {
    materi.downloads = (int.parse(materi.downloads) + 1).toString();
    launch(
        "${api.defaultAPI}frontend/rangkuman/download/${api.token}/${api.data.noSiswa}/${materi.noMateri}");
  }
}
