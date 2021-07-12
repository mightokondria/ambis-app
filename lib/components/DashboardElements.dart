import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/handlers/Tryout.dart';
import 'package:mentoring_id/api/models/Akun.dart';
import 'package:mentoring_id/api/models/Tryout.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/ContentLoading.dart';
import 'package:mentoring_id/reuseable/Information.dart';
import 'package:mentoring_id/reuseable/LineGraph.dart';
import 'package:mentoring_id/reuseable/TryoutList.dart';
import 'package:mentoring_id/reuseable/fancies/circle_icon.dart';
import 'package:mentoring_id/reuseable/input/CustomButton.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Messages.dart';

class IkhtisarNilai extends StatefulWidget {
  final API api;

  const IkhtisarNilai({Key key, this.api}) : super(key: key);

  @override
  _IkhtisarNilaiState createState() => _IkhtisarNilaiState();
}

class _IkhtisarNilaiState extends State<IkhtisarNilai> {
  bool triedCaching = false;

  @override
  Widget build(BuildContext context) {
    final api = widget.api,
        cats = TryoutHandler.kategori,
        colors = [mPrimary, Colors.blue, Colors.green, Colors.cyan],
        data = api.nilai.historia;
    List<GraphData> graph = [];
    Widget child;

    if (!triedCaching && data.isEmpty) {
      api.nilai.cacheHistory().then((value) => setState(() {
            triedCaching = true;
          }));

      return ContentLoading(
        height: 200,
      );
    }

    cats.asMap().forEach((i, kategori) {
      graph.add(GraphData(
          name: kategori,
          color: colors[i],
          data: data
              .where((nilai) =>
                  nilai.session.nmp
                      .toLowerCase()
                      .indexOf(kategori.toLowerCase()) >
                  -1)
              .map((e) => GraphLine(
                  value: (e.nilai == null) ? 0 : e.nilai.roundToDouble()))
              .toList()));
    });

    graph = graph.where((element) => element.data.length > 0).toList();

    if (triedCaching && data.isEmpty)
      child = Column(
        children: [
          SizedBox(height: 20),
          Messages.message(
              image: AssetImage("assets/img/msg/404.png"),
              title: "Oops!!",
              content:
                  "Nilai tryout kamu masih kosong nih! Yuk kerjain tryout dulu!"),
        ],
      );
    else
      child = LineGraph(data: graph, height: 200, gridCount: 5, fill: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Progress",
          description: "Progress nilai tryout kamu",
          clickable: false,
        ),
        SizedBox(height: 30),
        child,
        SizedBox(height: 10),
        CustomButton(
          value: "analisis selengkapnya",
          onTap: () =>
              api.showSnackbar(content: Text("Beta feature. Coming soon ya😁")),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title, description;
  final bool clickable;

  const SectionHeader(
      {Key key,
      @required this.title,
      this.description: "",
      this.clickable: true,
      Function onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      style: CustomButtonStyle.transparent(),
      padding: EdgeInsets.zero,
      enabled: clickable,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Color(0xFF555555),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                description,
                style: TextStyle(color: Color(0xFF888888), fontSize: 13),
              ),
            ],
          ),
          clickable
              ? Transform.rotate(
                  angle: pi,
                  child: Icon(Icons.arrow_back,
                      size: 25, color: Color(0xFF555555)),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class TryoutRecommendation extends StatefulWidget {
  final API api;

  const TryoutRecommendation({Key key, this.api}) : super(key: key);

  @override
  _TryoutRecommendationState createState() => _TryoutRecommendationState();
}

class _TryoutRecommendationState extends State<TryoutRecommendation> {
  List<PaketTryout> data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      widget.api.tryout.getRecommendation().then((value) => setState(() {
            data = value;
          }));

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          children: [
            Expanded(
              child: ContentLoading(),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(child: ContentLoading())
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SectionHeader(
            onTap: () => widget.api
                .screenChanger(widget.api.screenAdapter.isDesktop ? 2 : 3),
            title: "For you",
            description: "Rekomendasi tryout untukmu",
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          padding: EdgeInsets.only(left: 28, right: 10, top: 10, bottom: 10),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
              children: data
                  .map((e) => Row(children: [
                        TryoutList(e, widget.api),
                        SizedBox(width: 10),
                      ]))
                  .toList()),
        )
      ],
    );
  }
}

class GroupInvitations extends StatefulWidget {
  const GroupInvitations({
    Key key,
    @required this.api,
  }) : super(key: key);

  final API api;

  @override
  _GroupInvitationsState createState() => _GroupInvitationsState();
}

class _GroupInvitationsState extends State<GroupInvitations> {
  final icons = ["Whatsapp", "Telegram"];
  List<Groups> groups;

  Widget group({String icon}) => CustomButton(
        style: CustomButtonStyle(color: Colors.white),
        fill: false,
        padding: EdgeInsets.all(15),
        child: Image.asset(
          "assets/img/groups/$icon.png",
          width: 30,
        ),
      );

  Future<List<Groups>> getGroupsData() async {
    final List<Groups> cache = [];
    final List<Akun> akuns = widget.api.data.initialData.akun;

    for (int i = 0; i < akuns.length; i++) {
      await widget.api.request(
          path: "component/groups",
          animation: false,
          method: "POST",
          body: {"no_akun": akuns[i].noAkun}).then((value) {
        if (value.statusCode == 404) return null;

        final data = widget.api.safeDecoder(value.body);
        cache.add(Groups(data));
      });
    }

    return cache;
  }

  @override
  Widget build(BuildContext context) {
    if (groups == null) {
      getGroupsData().then((data) => setState(() {
            groups = data;
          }));

      return ContentLoading(
        width: double.infinity,
      );
    }

    return SomeInfo(
        api: widget.api,
        config: "groupsInvitation",
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Kamu sudah masuk grup diskusi belum? Kalau belum, yuk klik tombol di bawah ini!",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: groups
                .map((group) => Column(
                      children: [
                        SizedBox(height: 5),
                        groupsSection(data: group),
                      ],
                    ))
                .toList(),
          ),
        ]));
  }

  Widget groupsSection({Groups data}) {
    return Row(
        children: data.grup
            .map((e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    joinGroupButton(e),
                    SizedBox(width: 5),
                  ],
                ))
            .toList());
  }

  Widget joinGroupButton(Group data) {
    return CustomButton(
        onTap: () {
          launch(data.link);
        },
        fill: false,
        style: CustomButtonStyle(color: Colors.white),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/img/groups/Telegram.svg",
              width: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              data.judul,
              style: TextStyle(
                  color: Color(0xFF555555), fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}

class Groups {
  String nmAkun;
  int noAkun;
  List<Group> grup = [];

  Groups(Map<String, dynamic> json) {
    nmAkun = json['nm_akun'];
    noAkun = json['no_akun'];

    json['grup'].forEach((e) => grup.add(Group(e['judul'], e['link'])));
  }
}

class Group {
  final String judul, link;

  Group(this.judul, this.link);
}

class MobileDashboardProfile extends StatelessWidget {
  final API api;

  const MobileDashboardProfile({
    Key key,
    this.api,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/img/icons/profile.svg",
          width: 35,
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(api.data.nama,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF555555),
                )),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                CircleIcon(
                  tulisan: "XP",
                  warna: mPrimary,
                ),
                SizedBox(width: 5),
                Text(api.data.initialData.xp.toString(),
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 12,
                    )),
              ],
            )
          ]),
        )
      ],
    );
  }
}
