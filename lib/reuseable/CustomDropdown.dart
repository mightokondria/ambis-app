import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function onChange;
  final String value;
  final Widget hint;

  CustomDropdown({this.items, this.onChange, this.value, this.hint});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      child: Container(
        decoration: CustomCard.decoration(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: DropdownButton(
          onChanged: (value) {
            if (onChange != null) onChange(value);
          },
          hint: hint,
          underline: Container(),
          isExpanded: true,
          value: value,
          items: items,
        ),
      ),
    );
  }
}
