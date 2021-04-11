import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/dialog/RecoveryDialog.dart';

import '../API.dart';

class UI {
  final API api;
  BuildContext context;

  UI(this.api) {
    context = api.context;
  }

  // ACCOUNT RECOVERY DIALOG
  showRecoveryDialog() {
    if (api.parent.isDesktop)
      showGeneralDialog(
          context: context,
          pageBuilder: (context, a1, a2) => RecoveryDialog());
    else
      showBottomSheet(
          context: context, builder: (context) => RecoveryDialog());
  }
}
