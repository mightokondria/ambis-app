import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Kategori.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/class/Args.dart';
import 'package:mentoring_id/components/Messages.dart';

class TryoutHandler {
  final API api;
  TryoutHandler(this.api);

  static List<String> kategori = ["SAINTEK", "SOSHUM", "KEDINASAN", "SKD"];
  static String defaultKategori = "SAINTEK";
  static Widget notFoundMessage = Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Messages.message(
          image: AssetImage("assets/img/msg/404.png"),
          title: "Oopps..",
          content:
              "Tryout dengan keyword tersebut nggak ada. Coba keyword lain."));

  List<Kategori> cache = [];
  List<PaketTryout> recommendationCache;

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
        PaketTryout.fromJson(api.safeDecoder(value.body))));
  }

  mulai(PaketTryout data) {
    api.request(path: "tryout/mulai", method: "POST", body: {
      "no_paket": data.noPaket,
      // "no_siswa": api.data.noSiswa
    }).then((value) async {
      if (value.body == "forbiddenNotSubscribed")
        return api.ui.showShortMessageDialog(
            title: "Duh!",
            message: "Kamu belum berlangganan kelas tryout ini",
            type: "warning");

      await api.dataSiswa.changeXP(data.xp);
      kerjakan(data.noPaket, value.body);
    });
  }

  kerjakan(String noPaket, String data) {
    Navigator.pushNamed(api.context, "/kerjain",
        arguments: Args(data: {
          "session": TryoutSession.parse(api.safeDecoder(data)),
          "no_paket": noPaket
        }, api: api));
  }

  Future<Response> jawabSoal(String session, String noSesi, Pilihan data) {
    return api.request(path: "tryout/memilih", method: "POST", body: {
      "session": session,
      "no_sesi": noSesi,
      "no_sesi_soal": data.noSesiSoal,
      "no_sesi_soal_pilihan": data.noSesiSoalPilihan
    });
  }

  Future<Response> pindahMateri(String session, String noSesi) {
    return api.request(
        path: "tryout/pindah_materi",
        method: "POST",
        body: {"no_sesi": noSesi, "session": session});
  }

  akhiri(TryoutSession data) {
    final Map<String, dynamic> body = {
      "session": data.session,
      "no_sesi": data.noSesi
    };

    if (data.onetime) {
      body['onetime'] = 1;
      body['no_tryout'] = data.noTryout;
    }

    api
        .request(path: "tryout/akhiri", method: "POST", body: body)
        .then((value) async {
      final Map<String, dynamic> parsed = api.safeDecoder(value.body);

      api.closeDialog();

      if (parsed.containsKey("status") && parsed['status'] == "sessionEnded") {
        await api.nilai.getNilai(data.session);
        return api.nilai.cacheHistory();
      }

      api.showSnackbar(content: Text("Sesi berikutnya. Semangat!!💪😆"));
      kerjakan(
        parsed['no_paket'],
        value.body,
      );
    });
  }

  Future<List<PaketTryout>> getRecommendation() async {
    if (recommendationCache == null) {
      final List<PaketTryout> result = [];

      await api
          .request(
              path: "recommendation/tryout",
              method: "POST",
              body: {
                "total": 10,
              },
              animation: false)
          .then((value) {
        final cache = api.safeDecoder(value.body) as List<dynamic>;

        cache.forEach((tryout) {
          result.add(PaketTryout.fromJson(tryout));
        });
      });

      recommendationCache = result;
    }

    return recommendationCache;
  }
}
