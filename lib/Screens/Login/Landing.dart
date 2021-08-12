import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/conponents/splashScreen.dart';
import 'package:sezapp/model/user/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _id = -1;
  int _role;

  String infoText;

  @override
  void initState() {

    super.initState();
    _loadUserInfo();
    infoText="Loading...";
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _id = (prefs.getInt("id") ?? -1);

    _role = (prefs.getInt("roleId"));

    int timeout = 5;
    if (_id == -1) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      try{
        var response = await userInfo();

        if (response.statusCode == 200) {
          response = jsonDecode(response.body);
          if (_role == 2) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/doctorHome', ModalRoute.withName('/doctorHome'),
                arguments: (User.fromJson(response)));
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/patientHome', ModalRoute.withName('/patientHome'),
                arguments: (User.fromJson(response)));
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', ModalRoute.withName('/login'));
        }
      }on TimeoutException catch (e) {
        print('Timeout Error: $e');
      } on SocketException catch (e) {
        print('Socket Error: $e');
        setState(() {
          infoText="Connection error!";
        });
      } on Error catch (e) {
        print('General Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/SezApp2_white.png",height: 80,),
            SizedBox(height: 20,),
            Text(infoText,style: TextStyle(color: kLightColor),)
          ],
        ),
      ),
    );
  }
}
