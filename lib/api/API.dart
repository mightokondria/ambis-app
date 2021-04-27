import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mentoring_id/api/handlers/Invoice.dart';
// HANDLERS
import 'package:mentoring_id/api/handlers/Session.dart';
// MODELS
import 'package:mentoring_id/api/models/Siswa.dart';
import 'package:mentoring_id/components/Device.dart';
import 'package:mentoring_id/components/LoadingAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'handlers/DataSiswa.dart';
import 'handlers/Jurusan.dart';
import 'handlers/UI.dart';
import 'models/Invoice.dart';

// THIS IS THE CORE HANDLER
// THIS INITIALIZES THE APPLICATION
// UNTIL IT IS READY TO USE

class API {
  String token;
  SharedPreferences prefs;

  // INITAL STATE CONTAINS
  // ALL REQUIRED STATE AT THE BEGINNING
  // SUCH AS BOOLEAN WHETHER A USER IS LOGGED IN
  Map<String, dynamic> initialState = {
    "isLoggedIn": false,
    "tidakPunyaKelasLangganan": true,
    "ready": false
  };

  // LOGGED IN USER DATA
  Siswa data;

  // CONTEXT WITH NAVIGATOR
  BuildContext context;

  final String defaultAPI = "https://api.mentoring.web.id/";
  final String suffix = "!==+=!==";

  // CACHED VARIABLES
  List<PaymentModel> payments;

  // HANDLERS
  DeviceState parent;
  Session session;
  UI ui;
  Jurusan jurusan;
  DataSiswa dataSiswa;
  InvoiceHandler invoice;

  API(this.context);

  dynamic safeDecoder(String source) {
    Map<String, dynamic> data;

    try {
      data = jsonDecode(source);
    } catch (e) {
      print(e);
      showSnackbar(
          content: Text("Oops! Sepertinya ada yang salah"),
          action: SnackBarAction(label: "Laporkan", onPressed: () {}));
    }

    return data;
  }

  showSnackbar(
      {Widget content, SnackBarAction action, SnackBarBehavior behavior}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: content, behavior: behavior, action: action));
  }

  initHandlers() {
    session = Session(this);
    ui = UI(this);
    jurusan = Jurusan(this);
    dataSiswa = DataSiswa(this);
    invoice = InvoiceHandler(this);
  }

  networkDisconnected() {
    parent.changeIndex(1);
  }

  closeDialog(BuildContext dialogContext) {
    Navigator.pop(context);
  }

  refresh() async {
    await init();
    parent.changeIndex(0);
  }

  // DEFAULT HELPER REQUEST FUNCTION WITH TOKEN HEADER
  Future<Response> request({
    String path,
    bool frontend: true,
    bool animation: true,
    String method: "GET",
    Map<String, String> headers,
    Map<String, dynamic> body: const <String, dynamic>{},
  }) async {
    Uri uri = Uri.parse(defaultAPI + (frontend ? "frontend/" : "") + path);
    String parsedBody = "";
    Response response;
    BuildContext loadingContext;

    if (headers == null) headers = {};

    if (animation)
      Future.delayed(Duration.zero, () {
        showGeneralDialog(
            context: context,
            transitionDuration: Duration(seconds: 0),
            pageBuilder: (context, animation, secondaryAnimation) {
              loadingContext = context;

              return LoadingAnimation();
            });
      });

    body.forEach((key, value) {
      parsedBody += "$key=$value&";
    });

    headers["token"] = token;

    appendResponse(Response res) {
      response = res;

      if (animation) closeDialog(loadingContext);
    }

    try {
      if (method == "POST") {
        headers['Content-type'] = "application/x-www-form-urlencoded";
        await post(
          uri,
          headers: headers,
          body: parsedBody,
        ).then(appendResponse);
      } else
        await get(uri, headers: headers).then(appendResponse);
    } catch (e) {
      closeDialog(loadingContext);
      networkDisconnected();
    }

    return response;
  }

  Future<Map<String, dynamic>> init() async {
    // INITIALIZATION
    // GET TOKEN
    await get(Uri.parse(defaultAPI + "frontend/req_token/index")).then((value) {
      Map<String, dynamic> data = safeDecoder(value.body);
      this.token = data["token"];
    });

    // CHECK IF A USER IS LOGGED IN IN THIS DEVICE
    await isLoggedIn().then((status) => initialState["isLoggedIn"] = status);

    if (data != null) {
      initialState["tidakPunyaKelasLangganan"] =
          data.initialData.akun.length < 1;

      initialState["ready"] = data.initialData.ready;
    }

    return initialState;
  }

  Future getInitialData() async {
    await request(
            path: "siswa/get_initial_data",
            method: "POST",
            animation: false,
            body: {"no_siswa": data.noSiswa})
        .then((value) => data.registerInitialData(safeDecoder(value.body)));
  }

  // CHECK IF A USER IS ALREADY LOGGED IN
  Future<bool> isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("data");
    bool loggedIn = data != null;

    if (loggedIn) {
      this.data = Siswa(safeDecoder(data));

      await getInitialData();
    }

    return loggedIn;
  }
}
