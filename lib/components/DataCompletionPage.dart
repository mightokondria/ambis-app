import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Chip.dart';
import 'package:mentoring_id/reuseable/CustomDropdown.dart';
import 'package:mentoring_id/reuseable/Steps.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

class DataCompletionPage extends StatefulWidget {
  final API api;
  DataCompletionPage(this.api);

  @override
  State<DataCompletionPage> createState() => _DataCompletionPage(api);
}

class _DataCompletionPage extends State<DataCompletionPage> {
  final API api;
  bool isDesktop;
  List<DropdownMenuItem> jurusan = [];
  List<DropdownMenuItem> prodi = [];

  // DROPDOWNS VALUE
  String selectedJurusan;
  String selectedProdi;

  _DataCompletionPage(this.api) {
    isDesktop = api.parent.isDesktop;
  }

  @override
  initState() {
    api.jurusan.getJurusan().then((value) {
      setState(() {
        jurusan = value
            .map((e) => DropdownMenuItem(
                  child: Text(e.nmJurusan),
                  value: e.noJurusan,
                ))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = api.parent.width;
    double horizontalMargin = api.parent.isDesktop ? width * .2 : 50;
    double verticalMargin = 20;
    Map<String, dynamic> initial = api.initialState;

    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        color: mHeadingText.withOpacity(.03),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Tinggal beberapa langkah lagi!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: mHeadingText,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(height: 20),
              Steps(
                activeIndex: initial["ready"] ? 2 : 1,
                items: [
                  "Daftar menggunakan email",
                  "Isi identitas tambahan",
                  "Langganan kelas",
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(children: [
                  InputText(
                    textField: TextFormField(
                      decoration:
                          InputText.inputDecoration(hint: "Asal sekolah"),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Kelas",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: mHeadingText, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ChipGroup(
                      onChange: (List<CustomChip> value) {
                        print(value[0].value);
                      },
                      allowMultipleSelection: false,
                      chips: [
                        CustomChip(value: "X", selected: true),
                        CustomChip(value: "XI"),
                        CustomChip(value: "XII"),
                        CustomChip(value: "Gapyear"),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomDropdown(
                    items: jurusan,
                    value: selectedJurusan,
                    onChange: (val) {
                      setState(() {
                        selectedJurusan = val;
                      });

                    },
                    hint: Text("Jurusan impian"),
                  ),
                  (prodi.length < 1) ? Container() : SizedBox(height: 30),
                  (prodi.length < 1)
                      ? Container()
                      : CustomDropdown(
                          value: selectedProdi,
                          items: prodi,
                          hint: Text("Prodi tujuan")),
                  SizedBox(height: 20),
                  CustomButton(value: "Berikutnya"),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
