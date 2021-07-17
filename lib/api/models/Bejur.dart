class BejurModel {
  String noJurusan, jurusan, cinta, views, deskripsi;
  bool loved;

  BejurModel(Map<String, dynamic> data) {
    noJurusan = data['no_jurusan'].toString();
    jurusan = data['jurusan'];
    cinta = data['cinta'].toString();
    views = data['views'].toString();

    if (data.containsKey("deskripsi")) {
      loved = data.containsKey("loved") && data['loved'];
      deskripsi = data['deskripsi'];
    }
  }
}
