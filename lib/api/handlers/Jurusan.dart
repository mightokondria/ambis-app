import 'dart:convert';

import 'package:mentoring_id/api/models/Jurusan.dart';

import '../API.dart';

class Jurusan {
  final API api;

  Jurusan(this.api);

  Future<List<JurusanModel>> getJurusan() async {
    List<JurusanModel> jurusan;

    await api.request(path: "jurusan/get", animation: false).then((res) {
      List<dynamic> data = jsonDecode(res.body);
      jurusan = data.map((e) => JurusanModel.fromJson(e)).toList();
    });

    return jurusan;
  }

  Future<List<Prodi>> getProdi(String noJurusan) async {
    List<Prodi> prodi;

    await api.request(
        path: "jurusan/get?data=prodi",
        method: "POST",
        animation: false,
        body: {"no_jurusan": noJurusan}).then((res) {
      List<dynamic> data = jsonDecode(res.body);
      prodi = data.map((e) => Prodi.fromJson(e)).toList();
    });

    return prodi;
  }
}
