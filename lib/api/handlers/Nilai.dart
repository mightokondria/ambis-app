import 'package:flutter/material.dart';
import 'package:mentoring_id/api/models/Nilai.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/features/HistoryTryout.dart';
import 'package:mentoring_id/components/features/NilaiTryout.dart';

import '../API.dart';

class NilaiHandler {
  final API api;

  NilaiHandler(this.api);

  getHistory() {
    api.request(
        path: "tryout/history",
        method: "POST",
        body: {"no_siswa": api.data.noSiswa}).then((value) {
      final sessions = api.safeDecoder(value.body);
      final List<HistoryTryoutSession> data = [];
      sessions.forEach((val) => data.add(HistoryTryoutSession.parse(val)));

      Navigator.of(api.context).pushNamed("/${HistoryTryout.route}",
          arguments: Args(api: api, data: data));
    });
  }

  getNilai(String session) {
    api.request(
        path: "session/nilai",
        method: "POST",
        body: {"session": session}).then((value) {
      final NilaiPaket data = NilaiPaket(api.safeDecoder(value.body));
      Navigator.of(api.context).pushNamed("/${NilaiTryout.route}",
          arguments: Args(api: api, data: {"data": data}));
    });
  }
}
