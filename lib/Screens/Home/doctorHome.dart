import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();

}

class _DoctorHomeState extends State<DoctorHome> {
  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }
  @override
  Widget build(BuildContext context) {
    //final User args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("You are a doctor"),

              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: _handleLogout,
                child: Text("Logout"),
              )
            ],
          ),
        ));
  }
}
