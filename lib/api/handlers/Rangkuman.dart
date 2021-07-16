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

  Future<void> getRangkumanList() async {
    if (cache == null) {
      cache = [];
      await api.request(path: "rangkuman/result").then((res) {
        final List<dynamic> data = api.safeDecoder(res.body);

        data.forEach((element) {
          cache.add(Mapel(element));
        });
      });
    }

    Navigator.pushNamed(api.context, "/${Rangkuman.route}",
        arguments: Args(api: api, data: cache));
  }

  downloadRangkuman(String noMateri) => launch(
      "${api.defaultAPI}frontend/rangkuman/download/${api.token}/${api.data.noSiswa}/$noMateri");
}
