import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/api/models/Bejur.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/dialog/Dialogs.dart';

import '../API.dart';

class UI {
  final API api;

  Dialogs dialog;
  BuildContext context;

  UI(this.api);

  init() {
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
          builder: (context) => AnimatedPadding(
              duration: Duration(milliseconds: 100),
              padding: MediaQuery.of(context).viewInsets,
              child:
                  SingleChildScrollView(child: universal ? desktop : mobile)));
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
  showTryoutConfirmationDialog(PaketTryout data) {
    final Widget child = dialog.tryoutConfirmationDialog(data);

    showModal(
        desktop: Container(
          child: child,
        ),
        mobile: Wrap(
          children: [child],
        ));
  }

  showTryoutEndConfirmationDialog(Function onEnd) {
    final Widget child = dialog.tryoutEndConfirmationDialog(onEnd);

    showModal(
        desktop: child,
        mobile: Wrap(
          children: [child],
        ));
  }

  showUpdateEmailDialog() {
    final Widget child = dialog.emailUpdateDialog();

    showModal(
        desktop: child,
        mobile: Wrap(
          children: [child],
        ));
  }

  showUpdatePasswordDialog() {
    final Widget child = dialog.passwordUpdateDialog();

    showModal(
        desktop: child,
        mobile: Wrap(
          children: [child],
        ));
  }

  showShortMessageDialog(
      {String title: "Berhasil!",
      String message: "Berhasil dilakukan!",
      String type: "success",
      Widget additionalChild,
      double maxWidth: 200}) {
    final child = Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      decoration: CustomCard.decoration(),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/img/msg/$type.svg",
            width: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF555555),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF888888),
              )),
          SizedBox(
            height: 10,
          ),
          (additionalChild != null) ? additionalChild : SizedBox(),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (context) => Center(child: child),
    ).timeout(Duration(seconds: 5), onTimeout: () => api.closeDialog());
  }

  showBejurDialog(BejurModel data) {
    final child = dialog.bejurDialog(data);

    showModal(
        desktop: child,
        mobile: Wrap(
          children: [child],
        ));
  }
}
