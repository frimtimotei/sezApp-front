import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/screens/chat/chatHome.dart';
import 'package:sezapp/screens/patient/profile/patientUserPage.dart';
import 'package:sezapp/screens/doctor/home/doctorHomePage.dart';

import '../../constants.dart';

class DoctorMenu extends StatefulWidget {
  @override
  _DoctorMenuState createState() => _DoctorMenuState();
}

class _DoctorMenuState extends State<DoctorMenu> {
  int selectedPage = 0;
  final _pageOptions = [DoctorHomePage(), ChatHome(), PatientUser()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: kLightColor,
        height: 55,
        items: <Widget>[
          Icon(
            LineAwesomeIcons.home,
            size: 30,
            color: kPrimaryColor,
          ),
          Icon(
            LineAwesomeIcons.envelope,
            size: 30,
            color: kPrimaryColor,
          ),
          Icon(
            LineAwesomeIcons.user,
            size: 30,
            color: kPrimaryColor,
          ),
        ],
        animationCurve: Curves.easeOutSine,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
