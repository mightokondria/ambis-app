import 'dart:convert';

import 'package:mentoring_id/api/models/Jurusan.dart';

import '../API.dart';

class Jurusan {
  final API api;

  Jurusan(this.api);

  Future<List<JurusanModel>> getJurusan() async {
    List<JurusanModel> jurusan = <JurusanModel>[];

    await api.request(path: "jurusan/get", animation: false).then((res) {
      List<dynamic> data = jsonDecode(res.body);
      jurusan = data.map((e) => JurusanModel.fromJson(e)).toList();
    });

    return jurusan;
  }

  Future<List<Prodi>> getProdi() async {

  }
}
