import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DataCompletion/DataCompletionPage.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/Chip.dart';
import 'package:mentoring_id/reuseable/CustomDropdown.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

class AdditionalDataForm extends StatefulWidget {
  final DataCompletionPageState parent;

  const AdditionalDataForm({Key key, this.parent}) : super(key: key);

  @override
  _AdditionalDataFormState createState() => _AdditionalDataFormState(parent);
}

class _AdditionalDataFormState extends State<AdditionalDataForm> {
  final DataCompletionPageState parent;

  List<DropdownMenuItem> jurusan = [];
  List<DropdownMenuItem> prodi = [];
  API api;

  // DROPDOWNS VALUE
  String selectedJurusan;
  String selectedProdi;

  // KELAS CHIP
  String kelas;

  // CONTROLLERS
  TextEditingController sekolah = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _AdditionalDataFormState(this.parent) {
    api = parent.api;
  }

  @override
  initState() {
    super.initState();
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
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(children: [
            InputText(
              textField: TextFormField(
                validator: (val) => (val == null || val.length < 3)
                    ? "Isi sekolah dengan benar"
                    : null,
                controller: sekolah,
                decoration: InputText.inputDecoration(hint: "Asal sekolah"),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Kelas",
                textAlign: TextAlign.start,
                style:
                    TextStyle(color: mHeadingText, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: ChipGroup(
                onChange: (List<CustomChip> value) {
                  kelas = value[0].value;
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
              validator: (val) => (val == null) ? "Isi jurusan impianmu" : null,
              onChange: (val) {
                setState(() {
                  selectedJurusan = val;
                  prodi = [];
                  selectedProdi = null;
                });

                api.jurusan.getProdi(val).then((value) {
                  setState(() {
                    prodi = value
                        .map((e) => DropdownMenuItem(
                            value: e.noProdi, child: Text(e.nmProdi)))
                        .toList();
                  });
                });
              },
              hint: Text("Jurusan impian"),
            ),
            (prodi.length < 1) ? Container() : SizedBox(height: 10),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: (prodi.length < 1)
                  ? Container()
                  : CustomDropdown(
                      validator: (val) =>
                          (val == null) ? "Isi prodi tujuanmu" : null,
                      value: selectedProdi,
                      items: prodi,
                      onChange: (val) {
                        setState(() {
                          selectedProdi = val;
                        });
                      },
                      hint: Text("Prodi tujuan")),
            ),
            SizedBox(height: 20),
            CustomButton(
              value: "Berikutnya",
              onTap: () {
                if (!formKey.currentState.validate()) return null;

                api.dataSiswa.registerAdditionalData(
                    [sekolah.value.text, kelas, selectedProdi]).then((value) {
                  api.dataSiswa.getKelasLangganan().then((val) {
                    parent
                      ..registerKelases(val)
                      ..changeStep(2);
                  });
                });
              },
            )
          ]),
        ));
  }
}
