import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Kategori.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/components/Messages.dart';

class TryoutHandler {
  final API api;
  TryoutHandler(this.api);

  static List<String> kategori = ["SAINTEK", "SOSHUM", "KEDINASAN", "TPS"];
  static String defaultKategori = "SAINTEK";
  static Widget notFoundMessage = Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Messages.message(
          image: AssetImage("assets/img/msg/404.png"),
          title: "Oopps..",
          content:
              "Tryout dengan keyword tersebut nggak ada. Coba keyword lain."));

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

  confirm(String noPaket) {
    api.request(path: "tryout/confirm", method: "POST", body: {
      "no_paket": noPaket
    }).then((value) => api.ui.showTryoutConfirmationDialog(
        Tryout.fromJson(api.safeDecoder(value.body))));
  }

  kerjakan(String noPaket) {
    api.request(path: "/").then((value) => api.closeDialog());
  }
}
