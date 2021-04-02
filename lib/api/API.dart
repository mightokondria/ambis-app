import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

// MODELS
import 'package:mentoring_id/api/models/Siswa.dart';

// HANDLERS
import 'package:mentoring_id/api/handlers/Session.dart';

// THIS IS THE CORE HANDLER
// THIS INITIALIZES THE APPLICATION 
// UNTIL IT IS READY TO USE

class API {
  
  String token;
  SharedPreferences prefs;

  // INITAL STATE CONTAINS
  // ALL REQUIRED STATE AT THE BEGINNING
  // SUCH AS BOOLEAN WHETHER A USER IS LOGGED IN
  Map<String, dynamic> initialState = {};

  // LOGGED IN USER DATA
  Siswa data;

  final String defaultAPI = "api.mentoring.web.id";
  final String suffix = "!==+=!==";

  // HANDLERS
  Session session;

  API() {
    session = Session(this);
  }

  // DEFAULT HELPER REQUEST FUNCTION WITH TOKEN HEADER
  Future<Response> request({
    String path, 
    bool frontend: true,
    String method: "GET", 
    Map<String, String> headers: const <String, String> {},
    Map<String, dynamic> body: const <String, dynamic> {},
    }) {
      Uri uri = Uri.https(defaultAPI, (frontend? "frontend/" + path : path));
      String parsedBody = "";

      body.forEach((key, value) {
        parsedBody += "$key=$value&";
      });

      headers["token"] = token;
      
      if(method == "POST") {
        headers['Content-type'] = "application/x-www-form-urlencoded";
        return post(
          uri,
          headers: headers,
          body: parsedBody,
        );
      }

      return get(
        uri,
        headers: headers
      );
  }

  Future<Map<String, dynamic>> init() async {
    // INITIALIZATION
    // GET TOKEN
    await get(Uri.https(defaultAPI, "frontend/req_token/index")).then((value) {
      Map<String, dynamic> data = jsonDecode(value.body);
      this.token = data["token"];
    });

    // CHECK IF A USER IS LOGGED IN IN THIS DEVICE
    await isLoggedIn().then((status) => initialState["isLoggedIn"] = status);

    initialState["tidakPunyaKelasLangganan"] = (data != null)? data.akun.length < 1 : true;

    return initialState;
  }

  Future checkKelasLangganan() async {
    await request(path: "component/result_siswa", method: "POST", body: {
      "no_siswa": data.noSiswa
    }).then((value) => data.registerKelasLangganan(jsonDecode(value.body)));
  }

  // CHECK IF A USER IS ALREADY LOGGED IN
  Future<bool> isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("data");
    bool loggedIn = data != null;

    if(loggedIn) {
      this.data = Siswa(jsonDecode(data));

      await checkKelasLangganan();
    }

    return loggedIn;
  }

}