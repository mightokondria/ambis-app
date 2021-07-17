import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/api/models/Invoice.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class PendingInvoiceMobile extends StatefulWidget {
  final API api;

  PendingInvoiceMobile({Key key, this.api});

  @override
  _PendingInvoiceMobileState createState() => _PendingInvoiceMobileState();
}

class _PendingInvoiceMobileState extends State<PendingInvoiceMobile> {
  @override
  Widget build(BuildContext context) {
    final invoice = widget.api.initialState.pendingInvoice;
    Helpers.changeStatusBarColor();

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Header(),
              Content(invoice),
            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final Invoice invoice;

  Content(this.invoice);

  Widget contentText(String text, {Color color, bool doubleLineHeight: true}) =>
      SelectableText(text,
          style: TextStyle(
              color: color ?? Color(0xFF333333),
              height: doubleLineHeight ? 2 : 1));

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    children: [
                      TableRow(children: [
                        contentText("ID Pesanan"),
                        contentText(invoice.invoice),
                      ]),
                      TableRow(children: [
                        contentText("Pesanan"),
                        contentText("Kelas " + invoice.product.nmAkun),
                      ]),
                      TableRow(children: [
                        contentText("Total Pembayaran"),
                        contentText(Helpers.moneify(invoice.total)),
                      ]),
                      TableRow(children: [
                        contentText("Methode Pembayaran"),
                        contentText(invoice.method.pembayaran),
                      ]),
                      TableRow(children: [
                        contentText("Status"),
                        contentText("Menunggu konfirmasi", color: mPrimary),
                      ]),
                    ],
                  ),
                  SizedBox(height: 20),
                  contentText("Lakukan pembayaran ke " +
                      invoice.method.rekening +
                      " dengan menyertakan ID pesanan di berita transfer"),
                  SizedBox(height: 10),
                  contentText(
                      "Sudah melakukan pembayaran namun masih belum dikonfirmasi? Ingatkan admin dengan menekan tombol di bawah ini 👇"),
                  SizedBox(height: 20),
                  CustomButton(
                    value: "remind admin",
                  )
                ],
              ))
        ]);
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 80),
          Image.asset(
            "assets/img/msg/menunggu-konfirmasi.png",
            width: 150,
          ),
          SizedBox(height: 20),
          Text(
            "Menunggu konfirmasi",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF555555),
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          SizedBox(height: 8),
          Text(
            "Pesananmu sedang menunggu konfirmasi dari admin.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF888888),
            ),
          )
        ],
      ),
    );
  }
}
