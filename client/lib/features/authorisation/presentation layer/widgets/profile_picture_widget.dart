import 'package:flutter/material.dart';

class profilePictureWidget extends StatelessWidget {
  late double? widthProfilePic;
  late double? heightProfilePic;
  String? img;

  profilePictureWidget({this.widthProfilePic, this.heightProfilePic, this.img});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: img == null
              ? AssetImage('images/avatar.jpg') as ImageProvider
              : NetworkImage(img!),
          fit: BoxFit.cover,
          width: widthProfilePic,
          height: heightProfilePic,
          child: InkWell(onTap: () {}),
        ),
      ),
    );
  }
}
