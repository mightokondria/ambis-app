import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mentoring_id/api/handlers/Invoice.dart';
// HANDLERS
import 'package:mentoring_id/api/handlers/Session.dart';
import 'package:mentoring_id/api/models/InitialData.dart';
// MODELS
import 'package:mentoring_id/api/models/Siswa.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/components/ScreenAdapter.dart';
import 'package:mentoring_id/components/InitialScreens.dart';
import 'package:mentoring_id/components/LoadingAnimation.dart';
import 'package:mentoring_id/components/PaymentMethods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'handlers/DataSiswa.dart';
import 'handlers/Jurusan.dart';
import 'handlers/Tryout.dart';
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
  InitialState initialState = InitialState(false, true, false);
  InitialScreen initialScreens;
  Widget currentScreen;

  // LOGGED IN USER DATA
  Siswa data;

  // CONTEXT WITH NAVIGATOR
  BuildContext context;

  String defaultAPI =
      !kReleaseMode ? "https://api.mentoring.web.id/" : "http://localhost/";
  final String suffix = "!==+=!==";

  // CACHED VARIABLES
  List<PaymentModel> payments;
  PaymentMethodInstance paymentInstance;

  // HANDLERS
  ScreenAdapterState screenAdapter;
  Session session;
  UI ui;
  Jurusan jurusan;
  DataSiswa dataSiswa;
  InvoiceHandler invoice;
  TryoutHandler tryout;

  // CONSTRUCT
  API(this.context);

  // SESSION HELPER
  String encodeSession(Map<String, dynamic> data) {
    return base64.encode(utf8.encode(jsonEncode(data))) + suffix;
  }

  Siswa decodeSession(String session) {
    final int cut = 16;
    final String s = session;
    final int pos = (session.length / 2).round();
    final List<String> raw = [
      s.substring(pos - cut, pos),
      s.substring(0, pos - cut),
      s.substring(pos, s.length)
    ];
    final String decoded = utf8.decode(base64.decode(raw.join("")));

    return Siswa(safeDecoder(decoded));
  }
  // END SESSION HELPER

  // SCREEN ADAPTER HELPERS
  Widget getCurrentScreen() {
    return (currentScreen == null) ? Container() : currentScreen;
  }

  buildInitialScreen() {
    // SCREEN SWITCHER BASED ON INITIAL STATE
    final ist = initialState;
    final isc = initialScreens;
    final hasPendingInvoice = ist.pendingInvoice != null &&
        ist.pendingInvoice.isPending &&
        ist.tidakPunyaKelasLangganan;

    if (ist.isLoggedIn &&
        ist.ready &&
        !ist.tidakPunyaKelasLangganan &&
        !hasPendingInvoice)
      setCurrentScreen(isc.home);
    else if (!ist.isLoggedIn)
      setCurrentScreen(isc.login);
    else if ((!ist.ready || ist.tidakPunyaKelasLangganan) && !hasPendingInvoice)
      setCurrentScreen(isc.dataCompletion);
    else if (hasPendingInvoice) setCurrentScreen(isc.pendingInvoice);
  }

  setCurrentScreen(Widget screen) {
    currentScreen = screen;

    // REFRESH THE SCREEN ADAPTER
    screenAdapter.setState(() {});
  }
  // END SCREEN ADAPTER HELPERS

  dynamic safeDecoder(String source) {
    Map<String, dynamic> data;

    try {
      data = jsonDecode(source);
    } catch (e) {
      showSnackbar(
          content: Text("Oops! Sepertinya ada yang salah"),
          action: SnackBarAction(label: "Laporkan", onPressed: () {}));
    }

    return data;
  }

  showSnackbar(
      {Widget content, SnackBarAction action, SnackBarBehavior behavior}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: content, behavior: behavior, action: action));
  }

  networkDisconnected() {
    if (screenAdapter != null) screenAdapter.changeIndex(1);
  }

  closeDialog({BuildContext dialogContext}) {
    Navigator.pop(context);
  }

  refresh() async {
    Navigator.popAndPushNamed(context, "/");
  }

  // DEFAULT HELPER REQUEST FUNCTION WITH TOKEN HEADER
  Future<Response> request({
    String path,
    bool frontend: true,
    bool animation: true,
    String method: "GET",
    Map<String, String> headers,
    Map<String, dynamic> body: const <String, dynamic>{},
    bool auth: true,
  }) async {
    Uri uri = Uri.parse(defaultAPI + (frontend ? "frontend/" : "") + path);
    String parsedBody = "";
    Response response;

    if (headers == null) headers = {};

    if (animation)
      Future.delayed(Duration.zero, () {
        showGeneralDialog(
            context: context,
            transitionDuration: Duration(seconds: 0),
            pageBuilder: (context, animation, secondaryAnimation) =>
                LoadingAnimation());
      });

    body.forEach((key, value) {
      parsedBody += "$key=$value&";
    });

    if (auth) {
      headers["token"] = token;
      headers["no-siswa"] = data.noSiswa;
    }

    appendResponse(Response res) {
      response = res;

      if (animation) closeDialog();
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
      if (animation) closeDialog();
      networkDisconnected();
      return Future.error(e);
    }

    return response;
  }

  // INITIALIZERS
  Future<InitialState> init() async {
    prefs = await SharedPreferences.getInstance();

    // CHECK IF A USER IS LOGGED IN IN THIS DEVICE
    await isLoggedIn().then((status) => initialState.isLoggedIn = status);

    if (data != null) {
      final InitialData initialData = data.initialData;
      initialState.tidakPunyaKelasLangganan = initialData.akun.length < 1;
      initialState.ready = initialData.ready;
      initialState.pendingInvoice = initialData.invoice;

      // // CHECK IF THE USER HAS PENDING INVOICE
      // await hasPendingInvoice()
      //     .then((value) => initialState.pendingInvoice = value);
    }

    return initialState;
  }

  initActions() {
    if (data != null) {
      final InitialData initialData = data.initialData;
      final ActiveTryoutSession activeTryoutSession =
          initialData.activeTryoutSession;

      // IF USER HAS ACTIVE SESSION
      if (initialData.hasActiveSession)
        request(
            path: "tryout/kerjakan_sesi",
            method: "POST",
            body: {"session": activeTryoutSession.session}).then((value) {
          showSnackbar(content: Text("Tryout ini belum kamu kerjakan"));
          tryout.kerjakan(activeTryoutSession.nop, value.body);
        });
    }
  }

  initHandlers() {
    session = Session(this);
    ui = UI(this);
    jurusan = Jurusan(this);
    dataSiswa = DataSiswa(this);
    invoice = InvoiceHandler(this);
    tryout = TryoutHandler(this);
  }

  initScreenAdapter(
      ScreenAdapterState adapter, InitialScreen initialScreenInstance) {
    screenAdapter = adapter;
    initialScreens = initialScreenInstance;

    // INIT ALL HANDLERS
    initHandlers();

    // INIT ALL FIRST ACTIONS
    initActions();

    buildInitialScreen();
  }

  // END INITIALIZERS

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
    String token = prefs.getString("token");
    bool loggedIn = token != null;

    if (loggedIn) {
      this.token = token;
      await post(Uri.parse(defaultAPI + "frontend/auth/init"),
          body: {"token": token}).then((value) {
        if (value.statusCode == 403) {
          prefs.remove("token");
          return refresh();
        }
        data = decodeSession(value.body);
      });
      await getInitialData();
    }

    return loggedIn;
  }

  // CHECK IF THE USER HAS AN PENDING INVOICE
  Future<Invoice> hasPendingInvoice() async {
    Invoice result;
    await request(
            path: "invoice/my_invoice",
            method: "POST",
            animation: false,
            body: {"no_siswa": data.noSiswa})
        .then((value) => result = Invoice.fromJson(jsonDecode(value.body)));

    return result;
  }
}

// INITIAL STATES
class InitialState {
  bool isLoggedIn;
  bool tidakPunyaKelasLangganan;
  bool ready;
  Invoice pendingInvoice;

  InitialState(this.isLoggedIn, this.tidakPunyaKelasLangganan, this.ready);
}

// TOKEN CLASS
class Token {
  String token;
  int expiration;
  bool isEmpty;

  Token.decode(Map<String, dynamic> data) {
    isEmpty = data.isEmpty;

    if (!isEmpty) {
      token = data["token"];
      expiration = data["expiration"];
    }
  }

  Token(this.token, this.expiration);

  String encode() {
    return jsonEncode({"token": token, "expiration": expiration});
  }
}
