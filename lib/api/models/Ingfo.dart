class IngfoModel {
  String noInfo, judul, sumber, link, cover;

  IngfoModel(Map<String, dynamic> data) {
    noInfo = data['no_info'];
    judul = data['judul'];
    sumber = data['sumber'];
    link = data['link_sumber'];
    cover = data['cover'];
  }
}
