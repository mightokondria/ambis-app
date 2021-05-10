import 'dart:convert';

import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Kategori.dart';
import 'package:mentoring_id/api/models/Tryout.dart';

class TryoutHandler {
  final API api;
  TryoutHandler(this.api);

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
    final result = [];

    cache.forEach((kategori) {
      final temp = kategori.tryout
          .where((tryout) => (tryout.nmPaket.indexOf(keyword) > -1));
      result.add(temp);
    });

    return result;
  }
}
