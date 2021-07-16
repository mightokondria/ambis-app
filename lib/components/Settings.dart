import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Siswa.dart';
import 'package:mentoring_id/reuseable/Chip.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/Information.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:mentoring_id/reuseable/input/InputText.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final ProfileSiswa profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/img/icons/profile.svg",
          width: 100,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          profile.nama,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF555555)),
        ),
        Text(
          profile.asalSklh,
          style: TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
        ),
      ],
    );
  }
}

class EmailActivation extends StatelessWidget {
  const EmailActivation({
    Key key,
    @required this.api,
  }) : super(key: key);

  final API api;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () {
        api.request(path: "auth/send_activation_link", method: "POST", body: {
          // "no_siswa": api.data.noSiswa
        }).then((value) => api.ui.showShortMessageDialog(
            message:
                "Tautan aktivasi sudah dikirim ke emailmu. Cek folder spam jika belum masuk."));
      },
      style: CustomButtonStyle.transparent(),
      padding: EdgeInsets.zero,
      child: SomeInfo(
        api: api,
        message:
            "Email kamu belum aktif. Yuk aktifkan dengan menekan pesan ini!",
        config: "emailActivated",
      ),
    );
  }
}

class ProfileFooter extends StatelessWidget {
  const ProfileFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("© 2018 - 2021 Mentoring.id\nAll rights reserved",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black.withOpacity(.3)));
  }
}

class SettingsField extends StatelessWidget {
  final double padding;
  final Widget child;

  const SettingsField({Key key, this.padding: 20, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: CustomCard.decoration(),
        padding: EdgeInsets.all(padding),
        child: child);
  }
}

class IdentitySettings extends StatelessWidget {
  IdentitySettings(
      {Key key, @required this.controllers, @required this.kelas, this.api})
      : super(key: key);

  final List<TextEditingController> controllers;
  final List<String> kelases = ["X", "XI", "XII", "Gapyear"];
  final API api;
  final String kelas;

  @override
  Widget build(BuildContext context) {
    String selectedKelas = kelas;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SettingsField(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            InputWithLabel(
              controller: controllers[0],
              label: "Nama",
            ),
            SizedBox(height: 15),
            InputWithLabel(
              controller: controllers[1],
              label: "Asal sekolah",
            ),
            SizedBox(height: 15),
            InputWithLabel(
              controller: controllers[2],
              label: "WhatsApp",
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: ChipGroup(
                  onChange: (chips) {
                    selectedKelas = chips[0].value;
                  },
                  allowMultipleSelection: false,
                  chips: kelases
                      .map((e) =>
                          CustomChip(value: e, selected: e == selectedKelas))
                      .toList()),
            ),
            SizedBox(height: 15),
            CustomButton(
              value: "ubah",
              onTap: () async {
                if (!formKey.currentState.validate()) return null;

                final Map<String, dynamic> body = {
                  // "no_siswa": api.data.noSiswa,
                  "kelas": selectedKelas
                };

                ["nama", "asal_sklh", "no_wa"].asMap().forEach((key, val) {
                  body[val] = controllers[key].value.text;
                });

                await api.request(
                    path: "siswa/update", method: "POST", body: body);
                api.ui.showShortMessageDialog(
                    title: "Yeay!!",
                    message:
                        "Profile kamu sudah berhasil diubah! Yuk reload untuk melihat hasilnya!",
                    additionalChild: CustomButton(
                      value: "reload",
                      onTap: () => api
                        ..closeDialog()
                        ..refresh(),
                    ),
                    maxWidth: 250);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InputWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const InputWithLabel(
      {Key key, @required this.label, @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(color: Color(0xFF888888), fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 3,
        ),
        InputText(
          style: InputStyle.grayed,
          textField: TextFormField(
            validator: (value) {
              if (value.length < 5) return "isi minimal 5 karakter";

              return null;
            },
            controller: controller,
            decoration: InputText.inputDecoration(hint: label),
          ),
        ),
      ],
    );
  }
}

class GeneralSettings extends StatefulWidget {
  final API api;

  const GeneralSettings({Key key, this.api}) : super(key: key);

  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  bool webinarNotification, carouselInformation, forYouTryout;

  @override
  Widget build(BuildContext context) {
    if (webinarNotification == null) {
      webinarNotification = widget.api.data.initialData.webinarNotification;
      carouselInformation = widget.api.conf("carouselInformation");
      forYouTryout = widget.api.conf("forYouTryout");
    }

    return SettingsField(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsOptionWithSwitch(
          title: "Notifikasi webinar",
          description: "Dapatkan notifikasi webinar melalui email",
          value: webinarNotification,
          onTap: () {
            final bool change = !webinarNotification;

            setState(() {
              webinarNotification = widget.api.data.initialData
                  .webinarNotification = !webinarNotification;
            });
            widget.api.request(
                path: "settings/change",
                animation: false,
                method: "POST",
                body: {
                  // "no_siswa": widget.api.data.noSiswa,
                  "settings_name": "webinarNotification",
                  "settings_value": change ? 1 : 0,
                });
          },
        ),
        SizedBox(height: 10),
        SettingsOptionWithSwitch(
          title: "Informasi carousel",
          description: "Tampilkan informasi slideshow di dashboard",
          value: carouselInformation,
          onTap: () {
            final bool change = !carouselInformation;

            widget.api.conf("carouselInformation", value: change);
            setState(() {
              carouselInformation = change;
            });
          },
        ),
        SizedBox(height: 10),
        SettingsOptionWithSwitch(
          title: "For you tryout",
          description: "Tampilkan rekomendasi tryout di dashboard",
          value: forYouTryout,
          onTap: () {
            final bool change = !forYouTryout;

            widget.api.conf("forYouTryout", value: change);
            setState(() {
              forYouTryout = change;
            });
          },
        ),
        SizedBox(height: 10),
        SettingsOption(
          onTap: widget.api.ui.showUpdateEmailDialog,
          title: "Ganti email",
        ),
        SizedBox(height: 10),
        SettingsOption(
          onTap: widget.api.ui.showUpdatePasswordDialog,
          title: "Ganti password",
        ),
      ],
    ));
  }
}

class AdvancedSettings extends StatelessWidget {
  final API api;

  const AdvancedSettings({Key key, this.api}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SettingsField(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SettingsOption(
        title: "Logout",
        onTap: () {
          api
            ..prefs.remove("token")
            ..refresh();
        },
      ),
      SizedBox(height: 10),
      SettingsOption(
        title: "Hapus akun",
        color: Colors.red,
        onTap: () {},
      ),
    ]));
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;

  const SettingsOption(
      {Key key,
      this.title,
      this.color: const Color(0xFF555555),
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Clickable(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            child: Text(title,
                textAlign: TextAlign.start,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
        )));
  }
}

class SettingsOptionWithSwitch extends StatelessWidget {
  final String title, description;
  final bool value;
  final Function onTap;

  const SettingsOptionWithSwitch({
    Key key,
    @required this.title,
    this.description: "",
    @required this.value,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Clickable(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: Color(0xFF555555),
                                  fontWeight: FontWeight.bold)),
                          Text(description,
                              style: TextStyle(
                                color: Color(0xFF999999),
                              )),
                        ],
                      ),
                    ),
                    Switch(
                        value: value,
                        onChanged: (b) {
                          onTap();
                        })
                  ],
                ))));
  }
}
