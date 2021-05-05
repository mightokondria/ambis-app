import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletion/DataCompletionPage.dart';

class InitialScreen {
  final API api;
  final Widget login;
  final Widget home;
  final Widget pendingOrder;
  final Widget pengerjaanTryout;

  // UNIVERSAL OR RESPONSIVE PAGE(s)
  Widget dataCompletion;

  InitialScreen(this.api,
      {this.login, this.home, this.pendingOrder, this.pengerjaanTryout}) {
    dataCompletion = DataCompletionPage(api);
  }
}
