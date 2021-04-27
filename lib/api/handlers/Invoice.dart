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
}
