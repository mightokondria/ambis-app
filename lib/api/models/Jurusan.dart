class JurusanModel {
  String noJurusan;
  String nmJurusan;

  JurusanModel({this.noJurusan, this.nmJurusan});

  JurusanModel.fromJson(Map<String, dynamic> json) {
    noJurusan = json['no_jurusan'];
    nmJurusan = json['nm_jurusan'];
  }
}

class Prodi {
  String noProdi;
  String nmProdi;
  String noJurusan;

  Prodi({this.noProdi, this.nmProdi, this.noJurusan});

  Prodi.fromJson(Map<String, dynamic> json) {
    noProdi = json['no_prodi'];
    nmProdi = json['nm_prodi'];
    noJurusan = json['no_jurusan'];
  }
}
