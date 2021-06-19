import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage(
                'https://cdn.idntimes.com/content-images/post/20210112/img-20210112-181802-369e719c23d4a5951223af64d4b3f4e7.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(50)),
        ),
      ),
    );
  }
}
