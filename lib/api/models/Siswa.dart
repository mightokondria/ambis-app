import 'package:mentoring_id/api/models/Akun.dart';

class Siswa {

  String nama;
  String noSiswa;
  List<Akun> akun = [];
  
  Siswa(Map<String, dynamic> data) {
    nama = data["nama"];
    noSiswa = data["no_siswa"];
  }

  registerKelasLangganan(Map<String, dynamic> data) {
    List<dynamic> raw = data["akun"];

    raw.forEach((val) {
      akun.add(Akun(val));
    });
  }
}