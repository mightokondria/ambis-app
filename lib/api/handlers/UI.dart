import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/dialog/Dialogs.dart';

import '../API.dart';

class UI {
  final API api;

  Dialogs dialog;
  BuildContext context;

  UI(this.api) {
    context = api.context;
    dialog = Dialogs(api: api, context: context);
  }

  // ACCOUNT RECOVERY DIALOG
  showRecoveryDialog() {
    if (api.parent.isDesktop)
      showDialog(
          context: context,
          builder: (context) => dialog.recoveryDialog(context));
    else
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Color(0xFFF8F8F8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          builder: (context) => Wrap(
                children: [
                  dialog.recoveryDialog(context),
                ],
              ));
  }
}
