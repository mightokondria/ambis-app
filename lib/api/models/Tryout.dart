class DataTryout {
  String noKategori;
  String nmKategori;
  List<PaketTryout> tryout;

  DataTryout({this.noKategori, this.nmKategori, this.tryout});

  DataTryout.fromJson(Map<String, dynamic> json) {
    noKategori = json['no_kategori'];
    nmKategori = json['nm_kategori'];
    if (json['tryout'] != null) {
      tryout = <PaketTryout>[];
      json['tryout'].forEach((v) {
        tryout.add(new PaketTryout.fromJson(v));
      });
    }
  }
}

class PaketTryout {
  String noPaket;
  String nmPaket;
  String nmAkun;
  String xp;
  DateTime pubStart;
  DateTime pubEnd;
  String kategori;
  List<Tryout> tryouts;

  PaketTryout(
      {this.noPaket,
      this.nmPaket,
      this.nmAkun,
      this.xp,
      this.pubStart,
      this.pubEnd,
      this.kategori});

  PaketTryout.fromJson(Map<String, dynamic> json) {
    noPaket = json['no_paket'];
    nmPaket = json['nm_paket'];
    nmAkun = json['nm_akun'];
    xp = json['xp'];
    pubStart = json['pub_start'];
    pubEnd = json['pub_end'];
    kategori = json['kategori'];

    if (json.containsKey('tryouts')) {
      tryouts = [];

      json['tryouts'].forEach((e) {
        tryouts.add(Tryout.fromJson(e));
      });
    }
  }
}

class Tryout {
  String nmTryout;
  String noTryout;
  int durasi;
  int jmlSoal;

  Tryout({this.nmTryout, this.noTryout, this.durasi, this.jmlSoal});

  Tryout.fromJson(Map<String, dynamic> json) {
    nmTryout = json['nm_tryout'];
    noTryout = json['no_tryout'];
    durasi = json['durasi'];
    jmlSoal = json['jml_soal'];
  }
}

class TryoutMateri {
  String nmMateri, noSesi;

  TryoutMateri.fromJson(Map<String, dynamic> data) {
    nmMateri = data["nm_materi"];
    noSesi = data["no_sesi"];
  }
}

class TryoutSession {
  String nmMateri, nmTryout, session, noTryout, durasi, noSesi;
  bool selesai;
  List<Soal> soal;
  List<String> materi;
  int timestamp;

  TryoutSession.parse(Map<String, dynamic> data) {
    nmMateri = data['nm_materi'];
    nmTryout = data['nm_tryout'];
    session = data['session'];
    durasi = data['durasi'];
    timestamp = data['timestamp'];
    noSesi = data['no_sesi'];
    soal = [];
    materi = [];

    data['materi'].forEach((e) {
      materi.add(e.toString());
    });

    data['soal'].forEach((e) {
      soal.add(Soal.parse(e));
    });
  }
}

class Soal {
  String isiSoal, na, noSesiSoal;
  List<Pilihan> pilihan;

  Soal.parse(Map<String, dynamic> data) {
    isiSoal = data['isi_soal'];
    na = data['NA'];
    noSesiSoal = data['no_sesi_soal'];
    pilihan = [];

    data['pilihan'].forEach((e) {
      pilihan.add(Pilihan.parse(e));
    });
  }
}

class Pilihan {
  String isiPilihan, noSesiSoal, noSesiSoalPilihan;
  bool dipilih;

  Pilihan.parse(Map<String, dynamic> data) {
    isiPilihan = data['isi_pilihan'];
    noSesiSoal = data['no_sesi_soal'];
    noSesiSoalPilihan = data['no_sesi_soal_pilihan'];
    dipilih = data['dipilih'];
  }
}

class SimplifiedTryoutSession {
  String nop, nmp, session;

  SimplifiedTryoutSession.parse(Map<String, dynamic> data) {
    nop = data['nop'].toString();
    nmp = data['nmp'];
    session = data['session'];
  }
}
