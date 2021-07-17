import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/components/DashboardElements.dart';

class Dashboard extends StatefulWidget {
  final API api;

  const Dashboard({Key key, this.api}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
              width: constraints.maxWidth * .5,
              child: GroupInvitations(api: widget.api));
        }),
        SizedBox(height: 10),
        IkhtisarNilai(
          api: widget.api,
        ),
        SizedBox(height: 20),
        TryoutRecommendation(api: widget.api),
        SizedBox(height: 20),
      ],
    );
  }
}
