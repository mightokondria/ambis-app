class Mapel {
  String noMapel, nmMapel;
  List<RangkumanModel> rangkuman = [];

  Mapel(Map<String, dynamic> data) {
    noMapel = data['no_mapel'];
    nmMapel = data['nm_mapel'];

    data['rangkuman'].forEach((e) => rangkuman.add(RangkumanModel(e)));
  }

  Mapel.chips(this.noMapel, this.nmMapel);
}

class RangkumanModel {
  String noMateri, judulMateri, downloads, size;

  RangkumanModel(Map<String, dynamic> data) {
    noMateri = data['no_materi'];
    judulMateri = data['judul_materi'];
    downloads = data['downloads'];
    size = data['size'];
  }
}
