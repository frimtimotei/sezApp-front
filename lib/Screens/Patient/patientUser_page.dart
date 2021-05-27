import 'package:flutter/material.dart';

import 'package:sezapp/constants.dart';
import 'package:sezapp/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientUser extends StatefulWidget {
  @override
  _PatientUserState createState() => _PatientUserState();


}



class _PatientUserState extends State<PatientUser> {


  void _handleLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('id');
  prefs.remove("jwt");

  Navigator.pushNamedAndRemoveUntil(
  context, '/login', ModalRoute.withName('/login'));
  }





  @override
  Widget build(BuildContext context) {
    final User activeUser = ModalRoute.of(context).settings.arguments;


    return Container(
      color: kLightColor,
      child: Center(
        child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("you are a patient"),
                  Text(activeUser.email),
                  Text(activeUser.sex),


                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: _handleLogout,
                    child: Text("Logout"),
                  )
                ],
              ),
      ),
    );
  }
}
