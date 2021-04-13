import 'Akun.dart';
import 'Invoice.dart';

class InitialData {
  List<Akun> akun;
  bool ready;
  List<Invoice> invoice;

  InitialData({this.akun, this.ready, this.invoice});

  InitialData.fromJson(Map<String, dynamic> json) {
    if (json['akun'] != null) {
      akun = <Akun>[];
      json['akun'].forEach((v) {
        akun.add(Akun.fromJson(v));
      });
    }
    ready = json['ready'];
    if (json['invoice'] != null) {
      invoice = <Invoice>[];
      json['invoice'].forEach((v) {
        invoice.add(Invoice.fromJson(v));
      });
    }
  }
}
