import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletion/DataCompletionPage.dart';
import 'package:mentoring_id/components/desktop/PendingInvoice.dart';

class InitialScreen {
  final API api;
  final Widget login;
  final Widget home;
  final Widget pendingInvoice;
  final Widget dataCompletion;

  InitialScreen(this.api,
      {this.login, this.home, this.pendingInvoice, this.dataCompletion});
}
