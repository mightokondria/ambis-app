import 'package:flutter/material.dart';

class Rangkuman extends StatefulWidget {
  @override
  _RangkumanState createState() => _RangkumanState();
}

class _RangkumanState extends State<Rangkuman> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Expanded(
          child: FloatingActionButton.extended(
            onPressed: (){
              Navigator.pushNamed(context, '/pengerjaan_to');
            },
            backgroundColor: Colors.red,
            label: Text('KE PENGERJAAN'),
          ),
        ),
      );
  }
}
