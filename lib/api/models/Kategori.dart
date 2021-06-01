import 'package:mentoring_id/api/models/Tryout.dart';

class Kategori {
  int noKategori;
  String nmKategori;
  List<Tryout> tryout = [];

  Kategori(this.noKategori, this.nmKategori, {this.tryout});
  Kategori.fromJSON(Map<String, dynamic> data) {
    noKategori = int.parse(data["no_kategori"]);
    nmKategori = data["nm_kategori"];

    if (data.containsKey("tryout"))
      data["tryout"].forEach((v) {
        tryout.add(Tryout.fromJson(v));
      });
  }
}
