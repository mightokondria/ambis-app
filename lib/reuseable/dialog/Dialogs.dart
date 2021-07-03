import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/TryoutTimer.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/components/LoginForm.dart';
import 'package:mentoring_id/components/PaymentMethods.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/dialog/DialogElement.dart';
import 'package:mentoring_id/reuseable/fancies/KelasLanggananMenuCheck.dart';
import 'package:mentoring_id/reuseable/fancies/xp.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

import '../CustomCard.dart';

class Dialogs {
  final API api;
  final BuildContext context;

  // ALL FORM KEYS
  static final GlobalKey<FormState> recoveryFormKey = GlobalKey<FormState>();

  bool isDesktop = false;
  MainAxisSize mainAxisSize;

  Dialogs({this.context, this.api}) {
    isDesktop = api.screenAdapter.isDesktop;
    mainAxisSize = isDesktop ? MainAxisSize.min : MainAxisSize.max;
  }

  Widget recoveryDialog(context) {
    TextEditingController emailController = TextEditingController();

    return Center(
      child: DialogElement(
        api: api,
        child: Form(
          key: recoveryFormKey,
          child: Column(
            mainAxisSize: mainAxisSize,
            children: [
              Text(
                "Pemulihan password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mHeadingText,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                "Masukkan email akun yang ingin kamu pulihkan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mHeadingText.withOpacity(.4),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Material(
                child: InputText(
                  textField: TextFormField(
                    controller: emailController,
                    validator: LoginForm.emailValidator,
                    decoration: InputText.inputDecoration(hint: "Email"),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                value: "Pulihkan",
                onTap: () {
                  if (!recoveryFormKey.currentState.validate()) return null;

                  api.session.recovery(emailController).then((status) {
                    String message;

                    switch (status) {
                      case "recoveryLinkSent":
                        message = "Tautan pemulihan sudah dikirim ke emailmu.";
                        break;
                      case "emailNotRegisteredException":
                        message = "Email tidak terdaftar. Belum mendaftar?";
                        break;
                      default:
                        break;
                    }

                    if (status == "recoveryLinkSent") Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(message),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("TUTUP"))
                            ],
                          );
                        });
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomButton(
                  value: "Batal",
                  style: CustomButtonStyle.transparent(),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkoutDialog(KelasLanggananModel data) => CheckoutDialog(
        api: api,
        mainAxisSize: mainAxisSize,
        data: data,
      );

  Widget tryoutConfirmationDialog(PaketTryout data) {
    int jmlSoalTot = 0, durasiTot = 0;

    data.tryouts.forEach((val) {
      jmlSoalTot += val.jmlSoal;
      durasiTot += val.durasi;
    });

    final String durasiTotTranslated = TryoutTimer.translate(durasiTot);

    return Center(
      child: DialogElement(
        horizontalDesktopPadding: 30,
        // color: Colors.white,
        api: api,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.nmPaket,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(.5),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "$jmlSoalTot soal $durasiTotTranslated",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: XPWidget("+" + data.xp))
                ],
              ),
              SizedBox(height: 30),
              Text("Materi yang diujikan",
                  style: TextStyle(color: Colors.black45)),
              SizedBox(height: 5),
              ListView(
                shrinkWrap: true,
                children: data.tryouts.map((e) {
                  return Container(
                    decoration: CustomCard.decoration(),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.nmTryout,
                            style: TextStyle(
                                color: Colors.black.withOpacity(.5),
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                        Text(
                            "${e.jmlSoal} soal ${TryoutTimer.translate(e.durasi)}",
                            style: TextStyle(color: Colors.black38))
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      style: CustomButtonStyle.primary(shadow: false),
                      value: "kerjakan",
                      fill: false,
                      onTap: () {
                        api.tryout.mulai(data.noPaket);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      fill: false,
                      value: "batal",
                      style: CustomButtonStyle.semiPrimary(shadow: false),
                      onTap: () {
                        api.closeDialog();
                      },
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget tryoutEndConfirmationDialog(Function onEnd) {
    return Center(
        child: DialogElement(
      horizontalDesktopPadding: 30,
      api: api,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Konfirmasi",
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 10),
            Text("Kamu yakin mau mengakhiri sesi ini?",
                style: TextStyle(color: Color(0xFF999999))),
            SizedBox(height: 30),
            Row(children: [
              Expanded(
                  child: CustomButton(
                      value: "akhiri",
                      onTap: () {
                        api.closeDialog();
                        onEnd();
                      },
                      fill: false)),
              SizedBox(width: 5),
              Expanded(
                child: CustomButton(
                    value: "batal",
                    style: CustomButtonStyle.semiPrimary(),
                    onTap: () => api.closeDialog(),
                    fill: false),
              ),
            ]),
          ],
        ),
      ),
    ));
  }
}

class CheckoutDialog extends StatefulWidget {
  final API api;
  final MainAxisSize mainAxisSize;
  final KelasLanggananModel data;

  const CheckoutDialog({Key key, this.api, this.mainAxisSize, this.data})
      : super(key: key);
  @override
  _CheckoutDialogState createState() =>
      _CheckoutDialogState(api, mainAxisSize, data);
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final API api;
  final MainAxisSize mainAxisSize;
  final KelasLanggananModel data;
  final money = NumberFormat("##,###.00", "in-ID");
  final List<TextStyle> descs = [
    TextStyle(color: Colors.black54),
    TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF555555))
  ];
  final kopromForm = GlobalKey<FormState>();

  bool koprom = true;
  bool kopromUnavailable = false;
  String kopromUsed;
  Map<String, int> subtotal = {};
  int total = 0;
  TextEditingController kopromController;

  _CheckoutDialogState(this.api, this.mainAxisSize, this.data) {
    int hrg = int.parse(data.hrgStlhDiskon);
    subtotal[data.nmAkun] = hrg;
    total = hrg;
  }

  changeSubtotal(String name, int price) {
    setState(() {
      subtotal[name] = price;
      total += price;
    });
  }

  @override
  void initState() {
    kopromController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogElement(
        api: api,
        child: Form(
          child: Column(
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Checkout",
              //   style: TextStyle(
              //       color: mHeadingText,
              //       fontSize: 25,
              //       fontWeight: FontWeight.w600),
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.nmAkun,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: mHeadingText,
                          ),
                        ),
                        Text(
                          data.waktuAktif + " bulan membership",
                          style: TextStyle(
                            color: mHeadingText.withOpacity(.3),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              PaymentMethods(
                api: api,
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: Text("Punya kode promo?",
                    style: TextStyle(color: Colors.black54)),
                value: koprom,
                onChanged: (selected) {
                  setState(() {
                    koprom = selected;
                  });
                },
                contentPadding: EdgeInsets.all(0),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 10),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: koprom
                    ? Container(
                        decoration: CustomCard.decoration(),
                        child: Form(
                          key: kopromForm,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: TextFormField(
                                    enabled: kopromUsed == null,
                                    validator: (String val) {
                                      if (val.length < 6 || kopromUnavailable)
                                        return "Kode promo tidak tersedia";

                                      return null;
                                    },
                                    controller: kopromController,
                                    decoration: InputText.inputDecoration(
                                        hint: "Kode promo"),
                                    autofocus: true,
                                  ),
                                ),
                              ),
                              CustomButton(
                                enabled: kopromUsed == null,
                                fill: false,
                                onTap: () {
                                  kopromUnavailable = false;
                                  if (!kopromForm.currentState.validate())
                                    return null;

                                  api.invoice
                                      .checkKoprom(
                                          kopromController, data.noAkun)
                                      .then((value) {
                                    if (value["status"] == "unavail") {
                                      kopromUnavailable = true;
                                      kopromForm.currentState.validate();
                                      return null;
                                    }

                                    int potongan =
                                        int.parse("-" + value["potongan"]);
                                    setState(() {
                                      kopromUsed = value["id"];
                                      subtotal[value["nama"]] = potongan;
                                      total += potongan;
                                    });

                                    api.showSnackbar(
                                        content: Text(
                                            "Berhasil menggunakan kode promo!"));
                                  });
                                },
                                child: Wrap(
                                  children: [
                                    CustomPaint(
                                      size: Size(10, 10),
                                      painter: KelasLanggananMenuCheck(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                style: CustomButtonStyle.primary(radius: 100),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ),
              SizedBox(height: 30),
              ListView(
                shrinkWrap: true,
                children: subtotal.keys
                    .map((key) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(key, style: descs[0]),
                            Text(
                                "Rp. " + money.format(subtotal[key]).toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Total", style: descs[1]),
                Text("Rp. " + money.format(total).toString(),
                    textAlign: TextAlign.right, style: descs[1]),
              ]),
              SizedBox(height: 20),
              CustomButton(
                style: CustomButtonStyle.primary(radius: 30),
                value: "konfirmasi",
                onTap: () {
                  List<String> finalData = [
                    api.data.noSiswa,
                    data.noAkun,
                    api.paymentInstance.getAnswer().id,
                    kopromUsed,
                    total.toString()
                  ];
                  api.invoice.order(finalData);
                },
              ),
              CustomButton(
                style: CustomButtonStyle.transparent(),
                value: "batal",
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
