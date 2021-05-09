import 'package:flutter/material.dart';
import 'package:mentoring_id/api/models/Akun.dart';
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

  showModal(
      {bool universal: true,
      Widget desktop,
      Widget mobile,
      Color color: Colors.white,
      bool rounded: true}) {
    if (api.screenAdapter.isDesktop)
      showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, animation2) {
            final scale = Tween<double>(begin: .85, end: 1).animate(animation);

            return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                    scale: scale,
                    child: Scaffold(
                        backgroundColor: Colors.transparent, body: desktop)));
          });
    else
      showModalBottomSheet(
          backgroundColor: color,
          isScrollControlled: true,
          shape: rounded
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)))
              : null,
          context: context,
          builder: (context) => universal ? desktop : mobile);
  }

  // ACCOUNT RECOVERY DIALOG
  showRecoveryDialog() {
    showModal(
      universal: false,
      desktop: dialog.recoveryDialog(context),
      mobile: Wrap(
        children: [
          dialog.recoveryDialog(context),
        ],
      ),
    );
  }

  // SHOW CHECKOUT DIALOG
  showCheckoutDialog(KelasLanggananModel data) {
    showModal(
      universal: false,
      desktop: dialog.checkoutDialog(data),
      mobile: Wrap(
        children: [
          dialog.checkoutDialog(data),
        ],
      ),
    );
  }
}
