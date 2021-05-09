import 'package:flutter/material.dart';

import '../API.dart';

class InvoiceHandler {
  final API api;

  InvoiceHandler(this.api);

  Future<Map<String, dynamic>> checkKoprom(
      TextEditingController koprom, String n) async {
    Map<String, dynamic> result;

    await api.request(
        path: "koprom/get",
        method: "POST",
        body: {"kode": koprom.value.text, "n": n}).then((value) {
      String res = value.body;
      if (res == "noPromo")
        result = {"status": "unavail"};
      else
        result = api.safeDecoder(res);
    });

    return result;
  }

  Future order(List<String> data) async {
    final d = data;
    final body = {
      "no_siswa": d[0],
      "product": d[1],
      "method": d[2],
      "total": d[4]
    };

    if (d[3] != null) body['koprom'] = d[3];
    await api
        .request(path: "invoice/order", method: "POST", body: body)
        .then((value) => api.refresh());
  }
}
