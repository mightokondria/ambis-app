import 'package:flutter/material.dart';
import 'package:mentoring_id/constants/color_const.dart';
import 'package:mentoring_id/reuseable/input/Clickable.dart';

class SearchBar extends StatefulWidget {
  final Function(String value, bool empty) onSubmit;
  final String placeholder;
  final BorderRadius radius;
  final Color color;
  final bool shadow;

  const SearchBar(
      {Key key,
      this.onSubmit,
      this.placeholder: "Pencarian...",
      this.radius,
      this.color: Colors.white,
      this.shadow: true})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController searchController = TextEditingController();

  double kDefaultPadding = 60;

  onSubmitCallback(String val) => (widget.createElement() != null)
      ? widget.onSubmit(val, val.isEmpty)
      : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: (widget.radius == null)
              ? BorderRadius.circular(50)
              : widget.radius,
          boxShadow: widget.shadow
              ? [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      color: Colors.black26.withOpacity(0.06)),
                ]
              : []),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: onSubmitCallback,
              onChanged: onSubmitCallback,
              controller: searchController,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: TextStyle(color: Colors.black26.withOpacity(0.2)),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Clickable(
            child: GestureDetector(
                onTap: () {
                  onSubmitCallback(searchController.value.text);
                },
                child: Icon(Icons.search, color: mPrimary)),
          ),
        ],
      ),
    );
  }
}
