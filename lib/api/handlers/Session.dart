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
      resultData = jsonDecode(value.body);

      if (resultData["data"] == null)
        success = false;
      else
        success = true;
    });

    return success;
  }
}
