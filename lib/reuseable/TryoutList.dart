import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/reuseable/fancies/xp.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';

import 'CustomCard.dart';

TextStyle description = TextStyle(
  color: Colors.black.withOpacity(.3),
  fontSize: 12,
);

class TryoutList extends StatelessWidget {
  final PaketTryout data;
  final bool mobile;
  final API api;

  TryoutList(this.data, this.api, {this.mobile: false});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () {
        api.tryout.confirm(data.noPaket);
      },
      style: CustomButtonStyle.transparent(),
      padding: EdgeInsets.zero,
      fill: false,
      child: Container(
          width: 250 - (mobile ? 50.0 : 0.0),
          decoration: CustomCard.decoration(radius: 15),
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                XPWidget("+" + data.xp),
                SizedBox(height: 15),

                // NAMA/JUDUL TRYOUT
                Text(data.nmPaket.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black
                          .withOpacity(.5)
                          .withBlue(50)
                          .withGreen(20),
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    )),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // KELAS TRYOUT
                    // Text(data['nm_akun'].toUpperCase(), style: description,),
                    // DESKRIPSI TRYOUT
                    Text("Khusus kelas ${data.nmAkun}", style: description),
                  ],
                ),
              ])),
    );
  }
}
