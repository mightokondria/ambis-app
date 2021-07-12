import 'package:mentoring_id/api/models/Tryout.dart';

import 'Akun.dart';
import 'Invoice.dart';

class InitialData {
  List<Akun> akun;
  bool ready, webinarNotification, emailActivated, hasActiveSession = true;
  Invoice invoice;
  SimplifiedTryoutSession activeTryoutSession;
  String xp;

  InitialData({this.akun, this.ready, this.invoice});

  InitialData.fromJson(Map<String, dynamic> json) {
    if (json['akun'] != null) {
      akun = <Akun>[];
      json['akun'].forEach((v) {
        akun.add(Akun.fromJson(v));
      });
    }
    ready = json['ready'];
    invoice =
        (json['invoice'] != null) ? Invoice.fromJson(json['invoice']) : null;
    webinarNotification = json['webinarNotification'] == "1";
    emailActivated = json['emailActivated'];
    xp = json['xp'];

    final activeSessionRaw = json['activeTryoutSession'];
    if (activeSessionRaw.runtimeType == bool)
      hasActiveSession = false;
    else
      activeTryoutSession = SimplifiedTryoutSession.parse(activeSessionRaw);
  }
}
