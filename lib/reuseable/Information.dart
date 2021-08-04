import 'package:flutter/material.dart';
import 'package:mentoring_id/api/API.dart';

import 'CustomCard.dart';
import 'input/Clickable.dart';

class SomeInfo extends StatefulWidget {
  final Color color;
  final Widget child;
  final String config, message;
  final API api;

  const SomeInfo({
    Key key,
    this.color: Colors.blue,
    this.child,
    this.config,
    this.message,
    @required this.api,
  }) : super(key: key);

  @override
  _SomeInfoState createState() => _SomeInfoState();
}

class _SomeInfoState extends State<SomeInfo> {
  bool shown;
  API api;
  String conf;

  hidePermanently() {
    setState(() {
      shown = api.conf(conf, value: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    api = widget.api;
    conf = widget.config;
    shown = api.conf(conf);

    final Color textColor =
        (widget.color == Colors.white) ? Colors.black54 : Colors.white;

    return Padding(
      padding: EdgeInsets.only(bottom: shown ? 10.0 : 0),
      child: AnimatedCrossFade(
        crossFadeState:
            shown ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        sizeCurve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
        firstChild: Container(
          width: double.infinity,
          decoration: CustomCard.decoration(color: widget.color, radius: 5),
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: (widget.message != null)
                    ? Text(
                        widget.message,
                        style: TextStyle(color: textColor),
                      )
                    : widget.child,
              ),
              Clickable(
                child: GestureDetector(
                  onTap: hidePermanently,
                  child: Icon(Icons.close, size: 20, color: textColor),
                ),
              ),
            ],
          ),
        ),
        secondChild: SizedBox(height: 0, width: 0),
      ),
    );
  }
}
