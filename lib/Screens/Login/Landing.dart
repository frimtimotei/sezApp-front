import 'package:flutter/material.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _id = -1;
  int _role;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _id = (prefs.getInt("id") ?? -1);
    _role = (prefs.getInt("roleId"));
    if (_id == -1) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      var response = await userInfo();
      if(response["status"]==null) {
        if (_role == 2) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/doctorHome', ModalRoute.withName('/doctorHome'),
              arguments: (User.fromJson(response)));
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/patientHome', ModalRoute.withName('/patientHome'),
              arguments: (User.fromJson(response)));
        }
      }else{
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
