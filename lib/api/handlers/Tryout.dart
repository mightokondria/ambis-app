import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Kategori.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/components/Messages.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

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

  mulai(String noPaket) {
    api.request(path: "tryout/mulai", method: "POST", body: {
      "no_paket": noPaket,
      "no_siswa": api.data.noSiswa
    }).then((value) => kerjakan(noPaket, value.body));
  }

  kerjakan(String noPaket, String data) {
    if (data == "forbiddenNotSubscribed")
      return showDialog(
          context: api.context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/img/msg/mascott-sad.png",
                      width: 100,
                    ),
                    SizedBox(height: 10),
                    Text("Duh! Kamu belum berlangganan kelas ini"),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            );
          });

    Navigator.pushNamed(api.context, "/kerjain", arguments: {
      "data": {
        "session": TryoutSession.parse(api.safeDecoder(data)),
        "no_paket": noPaket
      },
      "api": api
    });
  }

  Future<Response> jawabSoal(String session, String noSesi, Pilihan data) {
    return api.request(path: "tryout/memilih", method: "POST", body: {
      "session": session,
      "no_sesi": noSesi,
      "no_sesi_soal": data.noSesiSoal,
      "no_sesi_soal_pilihan": data.noSesiSoalPilihan
    });
  }

  akhiri(TryoutSession data) {
    api.request(
        path: "tryout/akhiri",
        method: "POST",
        body: {"session": data.session, "no_sesi": data.noSesi}).then((value) {
      final Map<String, dynamic> parsed = api.safeDecoder(value.body);

      api.closeDialog();

      // TODO : Add action when session ends
      if (parsed.containsKey("status") && parsed['status'] == "sessionEnded")
        return null;

      api.showSnackbar(content: Text("Sesi berikutnya. Semangat!!💪😆"));
      kerjakan(
        parsed['no_paket'],
        value.body,
      );
    });
  }
}
