import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/api/models/InitialData.dart';

class Siswa {

  String nama;
  String noSiswa;
  List<Akun> akun = [];
  InitialData initialData;
  
  Siswa(Map<String, dynamic> data) {
    nama = data["nama"];
    noSiswa = data["no_siswa"];
  }

  registerInitialData(Map<String, dynamic> data) {
    initialData = InitialData.fromJson(data);
  }
}