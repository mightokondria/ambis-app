import 'package:flutter/material.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function onChange;
  final String value;
  final Widget hint;
  final Function validator;

  CustomDropdown(
      {this.items, this.onChange, this.value, this.hint, this.validator});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      child: Container(
        decoration: CustomCard.decoration(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: DropdownButtonFormField(
          decoration: InputDecoration(border: InputBorder.none),
          validator: validator,
          onChanged: (value) {
            if (onChange != null) onChange(value);
          },
          hint: hint,
          isExpanded: true,
          value: value,
          items: items,
        ),
      ),
    );
  }
}
