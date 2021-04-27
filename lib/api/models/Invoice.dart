class Invoice {
  String id;
  String invoice;
  String product;
  String noSiswa;
  String method;
  String koprom;

  Invoice(
      {this.id,
      this.invoice,
      this.product,
      this.noSiswa,
      this.method,
      this.koprom});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice = json['invoice'];
    product = json['product'];
    noSiswa = json['no_siswa'];
    method = json['method'];
    koprom = json['koprom'];
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
