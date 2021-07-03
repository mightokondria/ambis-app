import 'Tryout.dart';

class HistoryTryoutSession {
  SimplifiedTryoutSession session;
  double nilai, jumlahPeserta, persentase;
  String date;
  PeringkatModel peringkat;

  HistoryTryoutSession.parse(Map<String, dynamic> data) {
    session = SimplifiedTryoutSession.parse(data);
    nilai = data['nilai'].toDouble();
    date = data['date'];
    jumlahPeserta = data['jumlah_peserta'];
    peringkat = PeringkatModel.parse(data['peringkat']);
    persentase = ((nilai == null) ? 1 : nilai) / 1000;
  }
}

class PeringkatModel {
  PeringkatLevelModel nasional, jurusan;

  PeringkatModel.parse(dynamic data) {
    nasional = PeringkatLevelModel.parse(data['nasional']);
    jurusan = PeringkatLevelModel.parse(data['jurusan']);
  }
}

class PeringkatLevelModel {
  int jumlahPeserta;
  double peringkat;
  List<double> data = [];

  PeringkatLevelModel.parse(dynamic json) {
    jumlahPeserta = json['jumlah_peserta'];
    peringkat = json['peringkat'].toDouble();

    json['data'].forEach((val) {
      data.add(val.toDouble());
    });
  }
}

class NilaiPaket {
  HistoryTryoutSession nilai;
  List<NilaiTryoutModel> data = [];

  NilaiPaket(Map<String, dynamic> json) {
    nilai = HistoryTryoutSession.parse(json);

    json["data"].forEach((e) => NilaiTryoutModel(e));
  }
}

class NilaiTryoutModel {
  Tryout tryout;
  List<NilaiSesi> sesi = [];

  NilaiTryoutModel(Map<String, dynamic> data) {
    tryout = Tryout.fromJson(data);

    data["sesi"].forEach((materi) {
      sesi.add(NilaiSesi(materi));
    });
  }
}

class NilaiSesi {
  TryoutMateri materi;
  NilaiModel nilai;

  NilaiSesi(Map<String, dynamic> data) {
    materi = TryoutMateri.fromJson(data);
    nilai = NilaiModel(data["nilai"]);
  }
}

class NilaiModel {
  int benar, kosong, salah;
  double persentase, total;
  List<int> soalBenar = [];

  NilaiModel(Map<String, dynamic> data) {
    benar = data["benar"];
    kosong = data["kosong"];
    salah = data["salah"];
    total = data["total"].toDouble();
    persentase = data["persentase"].toDouble();

    data["soalBenar"].forEach(soalBenar.add);
  }
}
