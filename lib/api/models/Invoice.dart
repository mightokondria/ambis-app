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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice'] = this.invoice;
    data['product'] = this.product;
    data['no_siswa'] = this.noSiswa;
    data['method'] = this.method;
    data['koprom'] = this.koprom;
    return data;
  }
}