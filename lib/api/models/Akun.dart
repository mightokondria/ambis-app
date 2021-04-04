
class Akun {

  String nmAkun;
  bool active = true;

  Akun(Map<String, dynamic> data) {
    this.nmAkun = data["nm_akun"];

    if(data["active"] != null) this.active = (data["active"] == "1")? true : false;
  }
}