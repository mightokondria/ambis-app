import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/CustomCard.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class ChipGroup extends StatefulWidget {
  final List<CustomChip> chips;
  final bool allowMultipleSelection;
  final Function onChange;

  ChipGroup(
      {Key key, this.chips, this.allowMultipleSelection: true, this.onChange})
      : super(key: key);

  @override
  _ChipGroupState createState() =>
      _ChipGroupState(chips, allowMultipleSelection, onChange);
}

class _ChipGroupState extends State<ChipGroup> {
  final bool multiple;
  final Function onChange;

  List<CustomChip> chips;
  List<CustomChip> selection = [];

  _ChipGroupState(this.chips, this.multiple, this.onChange);

  select(int index) {
    setState(() {
      if (!multiple)
        chips = chips.map((e) {
          e.selected = false;
          return e;
        }).toList();

      chips[index].selected = !chips[index].selected;

      // MOVE ALL SELECTED CHIPS TO SELECTION VAR
      selection = chips.where((chip) => chip.selected).toList();

      if (onChange != null) onChange(selection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: chips.asMap().entries.map((e) {
        CustomChip chip = e.value;
        int index = e.key;

        return CustomChipElement(
          this,
          value: chip.value,
          selected: chip.selected,
          index: index,
        );
      }).toList(),
    );
  }
}

class CustomChip {
  final String value;
  bool selected;

  CustomChip({this.selected: false, this.value});
}

class CustomChipElement extends StatelessWidget {
  final String value;
  final bool selected;
  final int index;
  final _ChipGroupState parent;

  const CustomChipElement(this.parent,
      {Key key, this.selected, this.value, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Clickable(
      child: GestureDetector(
        onTap: () {
          parent.select(index);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            constraints: BoxConstraints(
              minWidth: 80,
            ),
            decoration: CustomCard.decoration(
                radius: 100, color: selected ? mPrimary : Colors.white),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected ? Colors.white : mHeadingText,
                ))),
      ),
    );
  }
}

class ChipSelection {
  bool selected;
  final Widget child;
  final String value;

  ChipSelection(this.selected, this.child, this.value);
}
