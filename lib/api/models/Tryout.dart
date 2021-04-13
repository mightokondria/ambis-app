class DataTryout {
  String noKategori;
  String nmKategori;
  List<Tryout> tryout;

  DataTryout({this.noKategori, this.nmKategori, this.tryout});

  DataTryout.fromJson(Map<String, dynamic> json) {
    noKategori = json['no_kategori'];
    nmKategori = json['nm_kategori'];
    if (json['tryout'] != null) {
      tryout = <Tryout>[];
      json['tryout'].forEach((v) {
        tryout.add(new Tryout.fromJson(v));
      });
    }
  }
}

class Tryout {
  String noPaket;
  String nmPaket;
  String nmAkun;
  String xp;
  DateTime pubStart;
  DateTime pubEnd;
  String kategori;

  Tryout(
      {this.noPaket,
      this.nmPaket,
      this.nmAkun,
      this.xp,
      this.pubStart,
      this.pubEnd,
      this.kategori});

  Tryout.fromJson(Map<String, dynamic> json) {
    noPaket = json['no_paket'];
    nmPaket = json['nm_paket'];
    nmAkun = json['nm_akun'];
    xp = json['xp'];
    pubStart = json['pub_start'];
    pubEnd = json['pub_end'];
    kategori = json['kategori'];
  }
}
