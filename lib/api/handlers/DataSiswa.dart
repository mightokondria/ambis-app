import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/api/models/Siswa.dart';

import '../API.dart';

class DataSiswa {
  final API api;

  DataSiswa(this.api);

  Future registerAdditionalData(List<String> data) async {
    // DATA INPUT [asal_sklh, kelas, prodi]
    await api
        .request(path: "auth/registerAdditionalData", method: "POST", body: {
      // "no_siswa": api.data.noSiswa,
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

  Future<ProfileSiswa> getProfileData() async {
    ProfileSiswa profile;

    await api.request(path: "siswa/get", method: "POST", body: {
      // "no": api.data.noSiswa
    }).then((value) => profile = ProfileSiswa(api.safeDecoder(value.body)));

    return profile;
  }

  Future<bool> changeXP(String xp) async {
    final currentXP = int.parse(api.data.initialData.xp),
        incrementedXP = (currentXP + int.parse(xp)).toString();

    api.data.initialData.xp = incrementedXP;
    await api.request(path: "settings/change", method: "POST", body: {
      "settings_name": "xp",
      "settings_value": incrementedXP
    }).then((value) => print(value.body));

    return true;
  }
}
