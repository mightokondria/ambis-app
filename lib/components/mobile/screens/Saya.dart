import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Siswa.dart';
import 'package:mentoring_id/class/Helpers.dart';

import '../../Settings.dart';

class Saya extends StatefulWidget {
  final API api;

  const Saya({Key key, this.api}) : super(key: key);

  @override
  _SayaState createState() => _SayaState();
}

class _SayaState extends State<Saya> {
  List<TextEditingController> controllers = [];
  ProfileSiswa profile;
  String kelas;

  @override
  void initState() {
    super.initState();
    controllers = Helpers.generateEditingControllers(3);
  }

  @override
  Widget build(BuildContext context) {
    Helpers.changeStatusBarColor(color: Color(0xFFF5F5F5));

    if (profile == null) {
      widget.api.dataSiswa.getProfileData().then((profileData) {
        setState(() {
          profile = profileData;
          // jurusan = jurusanData
          //     .map((e) => DropdownMenuItem(
          //           child: Text(e.nmJurusan),
          //           value: e.noJurusan,
          //         ))
          //     .toList();
        });

        [profile.nama, profile.asalSklh, profile.noWa]
            .asMap()
            .forEach((key, value) {
          controllers[key].value = TextEditingValue(text: value);
        });
        kelas = profile.kelas;
      });

      return Container();
    }

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Profile(profile: profile),
              ),
              SizedBox(height: 20),
              EmailActivation(api: widget.api),
              IdentitySettings(
                  controllers: controllers, kelas: kelas, api: widget.api),
              SizedBox(height: 10),
              GeneralSettings(
                api: widget.api,
              ),
              SizedBox(height: 10),
              AdvancedSettings(
                api: widget.api,
              ),
              SizedBox(height: 30),
              ProfileFooter(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
