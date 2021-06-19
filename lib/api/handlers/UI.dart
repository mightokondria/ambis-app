import 'package:flutter/material.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
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
      {bool universal: false,
      Widget desktop,
      Widget mobile,
      Color color: Colors.white,
      bool rounded: true}) {
    if (api.screenAdapter.isDesktop)
      showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "dialogBarrier",
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
    final Widget child = dialog.recoveryDialog(context);

    showModal(
      desktop: child,
      mobile: Wrap(
        children: [child],
      ),
    );
  }

  // SHOW CHECKOUT DIALOG
  showCheckoutDialog(KelasLanggananModel data) {
    final Widget child = dialog.checkoutDialog(data);

    showModal(
      desktop: child,
      mobile: Wrap(
        children: [
          child,
        ],
      ),
    );
  }

  // TRYOUT CONFIRM DIALOG
  showTryoutConfirmationDialog(Tryout data) {
    final Widget child = dialog.tryoutConfirmationDialog(data);

    showModal(
        desktop: Container(
          child: child,
        ),
        mobile: Wrap(
          children: [child],
        ));
  }
}
