import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mentoring_id/api/models/Nilai.dart';
import 'package:mentoring_id/api/models/Pembahasan.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/features/HalamanPembahasan.dart';
import 'package:mentoring_id/components/features/HistoryTryout.dart';
import 'package:mentoring_id/components/features/NilaiTryout.dart';

import '../API.dart';

class NilaiHandler {
  final API api;
  List<HistoryTryoutSession> historia = [];

  NilaiHandler(this.api);

  Future<bool> cacheHistory() async {
    final List<HistoryTryoutSession> cache = [];
    await api.request(
        path: "tryout/history",
        method: "POST",
        animation: false,
        body: {
          // "no_siswa": api.data.noSiswa
        }).then((value) {
      final sessions = api.safeDecoder(value.body);
      sessions.forEach((val) => cache.add(HistoryTryoutSession.parse(val)));
    });

    historia = cache;
    return true;
  }

  getHistory() => Navigator.of(api.context).pushNamed("/${HistoryTryout.route}",
      arguments: Args(api: api, data: historia));

  Future<Response> getNilai(String session) {
    return api.request(
        path: "session/nilai",
        method: "POST",
        body: {"session": session}).then((value) {
      final NilaiPaket data = NilaiPaket(api.safeDecoder(value.body));
      Navigator.of(api.context).pushNamed("/${NilaiTryout.route}",
          arguments: Args(api: api, data: data));

      return value;
    });
  }

  bahas(String session, String noTryout, String noSesi) {
    api.request(path: "pembahasan/bahas", method: "POST", body: {
      'session': session,
      'no_tryout': noTryout,
      'no_sesi': noSesi
    }).then((value) {
      final Pembahasan pembahasan = Pembahasan(api.safeDecoder(value.body));

      Navigator.pushNamed(api.context, "/${HalamanPembahasan.route}",
          arguments: Args(api: api, data: pembahasan));
    });
  }
}
