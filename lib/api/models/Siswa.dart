import 'package:mentoring_id/api/models/InitialData.dart';

class Siswa {
  String nama;
  String noSiswa;
  InitialData initialData;

  Siswa(Map<String, dynamic> data) {
    nama = data["nama"];
    noSiswa = data["no_siswa"];
  }

  registerInitialData(Map<String, dynamic> data) {
    initialData = InitialData.fromJson(data);
  }
}

class ProfileSiswa {
  String nama, asalSklh, kelas, noWa, email;

  ProfileSiswa(Map<String, dynamic> data) {
    nama = data["nama"];
    asalSklh = data["asal_sklh"];
    kelas = data["kelas"];
    noWa = data["no_wa"];
    email = data["email"];
  }
}
