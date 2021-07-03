import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/api/models/Akun.dart';

class Invoice {
  String id;
  String invoice;
  Akun product;
  String noSiswa;
  PaymentModel method;
  Koprom koprom;
  int total;
  bool isPending = false;

  Invoice(
      {this.id,
      this.invoice,
      this.product,
      this.noSiswa,
      this.method,
      this.koprom,
      this.total});

  Invoice.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      isPending = true;
      id = json['id'];
      invoice = json['invoice'];
      product = Akun.fromJson(json['product'], invoice: true);
      noSiswa = json['no_siswa'];
      method = PaymentModel.fromJson(json['method']);
      koprom = Koprom(json['koprom']);
      total = int.parse(json['total']);
    }
  }
}

class PaymentModel {
  String id;
  String pembayaran;
  String rekening;
  String logo;
  bool selected = false;

  PaymentModel({this.id, this.pembayaran, this.rekening, this.logo});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pembayaran = json['pembayaran'];
    rekening = json['rekening'];
    logo = json['logo'];
  }
}

class Koprom {
  String nama;
  String potongan;

  Koprom(Map<String, dynamic> data) {
    if (data != null) {
      nama = data["string"];
      potongan = "Rp. " + Helpers.moneify(int.parse(data["potongan"]));
    }
  }
}
