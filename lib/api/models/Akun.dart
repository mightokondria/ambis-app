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
    active = (json['active'] == '0') ? false : true;
  }
}

class KelasLanggananModel {
  String noAkun;
  String nmAkun;
  String hrgSblmDiskon;
  String diskon;
  String waktuAktif;
  String hrgStlhDiskon;
  List<KelasLanggananMenuModel> menu;

  KelasLanggananModel(
      {this.noAkun,
      this.nmAkun,
      this.hrgSblmDiskon,
      this.diskon,
      this.waktuAktif,
      this.hrgStlhDiskon,
      this.menu});

  KelasLanggananModel.fromJson(Map<String, dynamic> json) {
    noAkun = json['no_akun'];
    nmAkun = json['nm_akun'];
    hrgSblmDiskon = json['hrg_sblm_diskon'];
    diskon = json['diskon'];
    waktuAktif = json['waktu_aktif'];
    hrgStlhDiskon = json['hrg_stlh_diskon'];
    if (json['menu'] != null) {
      menu = new List<KelasLanggananMenuModel>();
      json['menu'].forEach((v) {
        menu.add(new KelasLanggananMenuModel.fromJson(v));
      });
    }
  }
}

class KelasLanggananMenuModel {
  String nmMenu;

  KelasLanggananMenuModel({this.nmMenu});

  KelasLanggananMenuModel.fromJson(Map<String, dynamic> json) {
    nmMenu = json['nm_menu'];
  }
}
