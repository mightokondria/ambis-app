import 'package:mentoring_id/api/models/Tryout.dart';

class Pembahasan {
  TryoutMateri materi;
  List<PembahasanSoal> pembahasan = [];

  Pembahasan(Map<String, dynamic> data) {
    materi = TryoutMateri.fromJson(data);

    data['pembahasan'].forEach((soal) {
      pembahasan.add(PembahasanSoal(soal));
    });
  }
}

class PembahasanSoal {
  String isiSoal, pembahasan;
  List<PembahasanPilihan> pilihan = [];
  int status;

  PembahasanSoal(Map<String, dynamic> data) {
    isiSoal = data['isi_soal'];
    pembahasan = data['pembahasan'];
    status = data['status'];

    data['pilihan'].forEach((pil) {
      pilihan.add(PembahasanPilihan(pil));
    });
  }
}

class PembahasanPilihan {
  Pilihan pilihan;
  bool jawaban;

  PembahasanPilihan(Map<String, dynamic> data) {
    jawaban = data['jawaban'] == "Y";
    pilihan = Pilihan.parse(data);
  }
}
