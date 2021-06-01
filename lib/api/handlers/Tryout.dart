import 'dart:convert';

import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Kategori.dart';

class TryoutHandler {
  final API api;
  TryoutHandler(this.api);

  static List<String> kategori = ["SAINTEK", "SOSHUM", "KEDINASAN", "TPS"];
  static String defaultKategori = "SAINTEK";

  List<Kategori> cache = [];

  Future<List<Kategori>> getTryoutData() async {
    if (cache.isEmpty)
      await api.request(path: "tryout/result", animation: false).then((value) {
        jsonDecode(value.body).forEach((v) {
          cache.add(Kategori.fromJSON(v));
        });
      });

    return cache;
  }

  List<Kategori> filterWithKategori(String kategori, {List<Kategori> data}) {
    return (data ?? cache).where((e) => (e.nmKategori == kategori)).toList();
  }

  List<Kategori> filter(String keyword) {
    final List<Kategori> result = [];

    cache.forEach((indexed) {
      Kategori kategori = Kategori(indexed.noKategori, indexed.nmKategori,
          tryout: indexed.tryout);
      kategori.tryout = kategori.tryout
          .where((tryout) =>
              (tryout.nmPaket.toLowerCase().indexOf(keyword.toLowerCase()) >
                  -1))
          .toList();
      result.add(kategori);
    });

    return result;
  }
}
