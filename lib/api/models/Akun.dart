class Akun {
  String noAkun;
  String nmAkun;
  String expired;
  bool active;

  Akun({this.noAkun, this.nmAkun, this.expired});

  Akun.fromJson(Map<String, dynamic> json) {
    noAkun = json['no_akun'];
    nmAkun = json['nm_akun'];
    expired = json['expired'];
    active = (json['active'] == '0')? false : true;
  }
}