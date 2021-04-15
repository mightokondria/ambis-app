import 'package:mentoring_id/api/models/Akun.dart';

import '../API.dart';

class DataSiswa {
  final API api;

  DataSiswa(this.api);

  Future registerAdditionalData(List<String> data) async {
    // DATA INPUT [asal_sklh, kelas, prodi]
    await api
        .request(path: "auth/registerAdditionalData", method: "POST", body: {
      "no_siswa": api.data.noSiswa,
      "asal_sklh": data.first,
      "kelas": data[1],
      "prodi": data.last,
    });
  }

  Future<List<KelasLanggananModel>> getKelasLangganan() async {
    List<KelasLanggananModel> result;

    await api.request(path: "berlangganan/result").then((value) {
      final List<dynamic> temp = api.safeDecoder(value.body)["akun"];

      result = temp.map((e) => KelasLanggananModel.fromJson(e)).toList();
    });

    return result;
  }
}
