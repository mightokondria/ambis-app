import 'package:flutter/material.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/reuseable/fancies/xp.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

import 'CustomCard.dart';

TextStyle description = TextStyle(
  color: Colors.black.withOpacity(.3),
  fontSize: 12,
);

class TryoutList extends StatelessWidget {
  final Tryout data;
  final bool mobile;

  TryoutList(this.data, {this.mobile: false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(data.noPaket);
      },
      child: Clickable(
        child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
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
      ),
    );
  }
}
