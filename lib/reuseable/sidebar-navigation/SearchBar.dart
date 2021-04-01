import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  double KDefaultPadding = 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 40,
           left: 0,
           right: 0,
           child: Container(
             alignment: Alignment.center,
             margin: EdgeInsets.symmetric(horizontal: KDefaultPadding),
             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(50),
               boxShadow: [ BoxShadow(
                 offset: Offset(0, 4),
                 blurRadius: 6,
                 color: Colors.black26.withOpacity(0.06)
               ),
                 ]
             ),
             child: Row(
               children: [
                 Expanded(
                   child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari Tryout...",
                      hintStyle: TextStyle(color: Colors.black26.withOpacity(0.2)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                   ),
                 ),
                 InkWell(
                   child: GestureDetector(
                     onTap: (){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         content: Text('cari...'),
                       )
                       );
                     },
                       child: Image.asset("assets/img/icons/search.png",)
                   ),
                 ),
               ],
             ),
           ),
          ),
        ],
      ),
    );
  }
}