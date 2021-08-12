import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/user/User.dart';


class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback callback;
  final Icon icon;
  const ProfileWidget({Key key, @required this.imagePath,@required this.callback, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          buildImage(checkImagePath(imagePath)),
          Positioned(
              bottom: 0,
              right: 4,

              child: ClipOval(
                child: Container(
                  padding: EdgeInsets.all(3),
                  color: kLightColor,
                  child: ClipOval(
                    child: Container(
                        padding: EdgeInsets.all(8),
                        color: kPrimaryLightColor,
                        child: icon),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  String checkImagePath(String imagePath){
    if(imagePath==null)
      return "https://sezapp-images.s3.eu-central-1.amazonaws.com/profilePicture.jpg";
    else return imagePath;
  }

 Widget buildImage(String imagePath) {

   return ClipOval(
     child: Material(
       color: Colors.transparent,
       child: Ink.image(
         image: NetworkImage(imagePath),
         height: 118,
         width: 118,
         fit: BoxFit.cover,
         child: InkWell(onTap: callback,),
       ),
     ),
   );
 }
}
