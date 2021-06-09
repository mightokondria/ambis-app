import 'package:flutter/material.dart';

class HalamanUtamaTryout extends StatefulWidget {
  @override
  _HalamanUtamaTryoutState createState() => _HalamanUtamaTryoutState();
}

class _HalamanUtamaTryoutState extends State<HalamanUtamaTryout> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Container(
      child: ElevatedButton(
        child: Text("Close"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
