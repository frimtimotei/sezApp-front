import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/screens/chat/chatHome.dart';
import 'package:sezapp/screens/patient/home/patientHomePage.dart';
import 'package:sezapp/screens/profile/patientUserPage.dart';
import 'package:sezapp/screens/patient/reports/reportsHome.dart';
import 'package:sezapp/screens/patient/add/addHomePage.dart';
import 'package:sezapp/constants.dart';

class PatientMenu extends StatefulWidget {
  @override
  _PatientMenuState createState() => _PatientMenuState();
}

class _PatientMenuState extends State<PatientMenu> {
  int selectedPage = 0;
  final _pageOptions = [
    PatientHomePage(),
    ChatHome(),
    PatientAddPage(),
    ReportsHome(),
    PatientUser()
  ];

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
            LineAwesomeIcons.plus,
            size: 30,
            color: kPrimaryColor,
          ),
          Icon(
            LineAwesomeIcons.bar_chart_1,
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
