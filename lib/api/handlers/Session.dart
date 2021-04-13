// THIS HANDLER HANDLES :
// LOGIN, LOGOUT, REGISTER, AND
// PASSWORD RECOVERY SYSTEM

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';

class Session {
  final API api;
  Session(this.api);

  Map<String, dynamic> resultData;

  save() {
    Map<String, dynamic> result = resultData["data"];

    if (result != null) {
      api.prefs.setString("data", jsonEncode(result));
      api.refresh();
    }
  }

  Future<bool> masuk(List<TextEditingController> data) async {
    List<String> values = [];
    bool success = false;

    data.forEach((element) {
      values.add(element.value.text);
    });

    await api.request(
      path: "auth/login",
      frontend: true,
      method: "POST",
      body: {"email": values[0], "password": values[1]},
    ).then((value) {
      resultData = api.safeDecoder(value.body);

      if (resultData["data"] == null)
        success = false;
      else
        success = true;
    });

    return success;
  }

  Future<String> register(List<TextEditingController> input) async {
    String result;
    List<String> inputs = input.map((e) => e.value.text).toList();

    await api.request(path: "auth/register", method: "POST", body: {
      "nama": inputs[0],
      "email": inputs[1],
      "password": inputs[3]
    }).then((value) {
      result = value.body;

      if (result == "emailDuplicationException")
        return api.showSnackbar(
            content: Text("Email sudah pernah dipakai. Lupa password?"));

      resultData = api.safeDecoder(result);
      save();
      api.showSnackbar(content: Text("Yeayy! Pembuatan akunmu sudah berhasil! Silakan ikuti langkah berikutnya."));
    });
  }

  Future<String> recovery(TextEditingController email) async {
    String result;

    await api.request(
        path: "auth/recovery",
        method: "POST",
        body: {"email": email.value.text}).then((res) {
      Map<String, dynamic> data = api.safeDecoder(res.body);
      result = data["status"];
    });

    return result;
  }
}
