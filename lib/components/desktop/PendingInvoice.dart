import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/Helpers.dart';
import 'package:mentoring_id/api/models/Invoice.dart';

import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

class PendingInvoice extends StatelessWidget {
  final API api;
  final scrollController = ScrollController();

  PendingInvoice({Key key, this.api}) : super(key: key) {
    invoice = api.initialState.pendingInvoice;
  }

  Invoice invoice;
  Widget contentText(String text, {Color color, bool doubleLineHeight: true}) =>
      SelectableText(text,
          style: TextStyle(
              color: color ?? Color(0xFF333333),
              height: doubleLineHeight ? 2 : 1));

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white..blue,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: EdgeInsets.all(30),
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/img/msg/menunggu-konfirmasi.png",
                  width: 150,
                ),
                SizedBox(height: 20),
                Text(
                  "Menunggu konfirmasi",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
                SizedBox(height: 8),
                Text(
                  "Pesananmu sedang menunggu konfirmasi dari admin.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF888888),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: CustomPaint(
              painter: _PendingInvoiceHeader(),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(100),
                  decoration: CustomCard.decoration(),
                  width: 500,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 17, horizontal: 25),
                            decoration: BoxDecoration(
                                color: mSemiPrimary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "Detail pesanan",
                              style: TextStyle(color: mPrimary, fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
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
                                      contentText(
                                          "Kelas " + invoice.product.nmAkun),
                                    ]),
                                    TableRow(children: [
                                      contentText("Total Pembayaran"),
                                      contentText(
                                          Helpers.moneify(invoice.total)),
                                    ]),
                                    TableRow(children: [
                                      contentText("Methode Pembayaran"),
                                      contentText(invoice.method.pembayaran),
                                    ]),
                                    TableRow(children: [
                                      contentText("Status"),
                                      contentText("Menunggu konfirmasi",
                                          color: mPrimary),
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
                                SizedBox(height: 10),
                                CustomButton(
                                  value: "remind admin",
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}

class _PendingInvoiceHeader extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = Paint()
      ..style = PaintingStyle.fill
      ..color = mPrimary;
    final w = size.width, h = size.height, path = Path();

    path
      ..moveTo(w, 0)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..lineTo(w - (w * (1 - .05)), 0)
      ..lineTo(w, 0)
      ..close();
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
