import 'package:flutter/material.dart';
// colors constants
const kPrimaryColor= Color(0xFF35477D);
const kPrimaryLightColor= Color(0xFF585ce5);
const kSecondaryColor= Color(0xFF3dc0f6);
const kSecondaryLightColor= Color(0xFFC06C84);
const kLightColor=Color(0xFFf2f6fe);

const kRedTextColor=Color.fromRGBO(224, 109, 109, 0.8);
const kRedBackColor=Color.fromRGBO(255, 167, 167, 0.6);

const kGreenTextColor=Color.fromRGBO(100, 172, 141, 0.8);
const kGreenBackColor=Color.fromRGBO(162, 219, 184, 0.6);
const kYellowBackColor = Color.fromRGBO(248, 219, 163, 0.6);
const kYellowTextColor = Color.fromRGBO(227, 174, 68, 8.0);
const kGreyBackColor = Color.fromRGBO(158, 152, 152, 0.6);
const kGreyTextColor = Color.fromRGBO(108, 104, 104, 0.8);

const List<Color> kListBackColors=[
  Color.fromRGBO(255, 167, 167, 0.6),
  Color.fromRGBO(100, 172, 141, 0.6),
  Color.fromRGBO(248, 219, 163, 0.6),
  Color.fromRGBO(163, 248, 231, 0.6),
  Color.fromRGBO(208, 167, 255, 0.6),
  Color.fromRGBO(97, 250, 171, 0.6),
  Color.fromRGBO(250, 163, 97, 0.6),
  Color.fromRGBO(250, 97, 189, 0.6),
  Color.fromRGBO(97, 189, 250, 0.6),
  Color.fromRGBO(255, 167, 167, 0.6),
  Color.fromRGBO(100, 172, 141, 0.6),
  Color.fromRGBO(248, 219, 163, 0.6),
  Color.fromRGBO(163, 248, 231, 0.6),


]    ;

const List<Color> kListTextColors=[
  Color.fromRGBO(191, 124, 124, 1),
  Color.fromRGBO(74, 147, 119, 1),
  Color.fromRGBO(121, 105, 68, 1.0),
  Color.fromRGBO(59, 113, 102, 1.0),
  Color.fromRGBO(81, 53, 109, 1.0),
  Color.fromRGBO(41, 94, 65, 1.0),
  Color.fromRGBO(95, 65, 41, 1.0),
  Color.fromRGBO(109, 48, 88, 1.0),
  Color.fromRGBO(40, 69, 88, 1.0),
  Color.fromRGBO(191, 124, 124, 1),
  Color.fromRGBO(74, 147, 119, 1),
  Color.fromRGBO(121, 105, 68, 1.0),
  Color.fromRGBO(59, 113, 102, 1.0),

]   ;

// api web

String baseUrl =
    //'http://10.0.2.2:8080';
'https://sezapp-backend.herokuapp.com';

String checkImagePath(String imagePath) {
  if (imagePath == null)
    return "https://sezapp-images.s3.eu-central-1.amazonaws.com/profilePicture.jpg";
  else
    return imagePath;
}