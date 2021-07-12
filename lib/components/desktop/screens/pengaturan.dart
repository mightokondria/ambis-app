import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Siswa.dart';
import 'package:mentoring_id/class/Helpers.dart';
import 'package:mentoring_id/components/LoadingAnimation.dart';

import '../../Settings.dart';

class Pengaturan extends StatefulWidget {
  final API api;

  const Pengaturan({Key key, this.api}) : super(key: key);

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  ProfileSiswa _profile;
  List<TextEditingController> controllers;
  String kelas;

  @override
  void initState() {
    super.initState();
    controllers = Helpers.generateEditingControllers(3);
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      widget.api.dataSiswa.getProfileData().then((value) {
        setState(() {
          _profile = value;
          kelas = value.kelas;
        });

        [value.nama, value.asalSklh, value.noWa].asMap().forEach((key, value) {
          controllers[key].value = TextEditingValue(text: value);
        });
      });

      return Center(
        child: LoadingAnimation.animation(),
      );
    }

    return Container(
        child: Column(
      children: [
        SizedBox(height: 30),
        Align(
          alignment: Alignment.topCenter,
          child: Profile(
            profile: _profile,
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              EmailActivation(api: widget.api),
              SizedBox(height: 10),
              IdentitySettings(
                  controllers: controllers, kelas: kelas, api: widget.api),
              SizedBox(height: 20),
              GeneralSettings(api: widget.api),
              SizedBox(height: 20),
              AdvancedSettings(api: widget.api),
              SizedBox(height: 20),
              ProfileFooter()
            ],
          ),
        )
      ],
    ));
  }
}
