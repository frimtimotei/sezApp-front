import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Add/add_page.dart';
import 'package:sezapp/Screens/Patient/Chat/chatHome.dart';
import 'package:sezapp/Screens/Patient/Chat/chatTest.dart';
import 'package:sezapp/Screens/Patient/Reports/reports_home.dart';
import 'package:sezapp/Screens/Patient/Reports/Seizures/seziuresActions.dart';
import 'package:sezapp/Screens/Patient/Home/patientHome_page.dart';
import 'package:sezapp/Screens/Patient/Profile/patientUser_page.dart';
import 'package:sezapp/conponents/splashScreen.dart';
import 'package:sezapp/constants.dart';




class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {






  int selectedPage=0;
  final _pageOptions=[
      PatientHomePage(),
      ChatHome(),
      PatientAddPage(),
      ReportsHome(),
      PatientUser()

  ];
  @override
  Widget build(BuildContext context) {
   // final User args = ModalRoute.of(context).settings.arguments;


    return Scaffold(
         body: _pageOptions[selectedPage],


        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: kLightColor,
          height: 55,
          items: <Widget>[
            Icon(LineAwesomeIcons.home,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.envelope,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.plus,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.bar_chart_1,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.user,size: 30,color: kPrimaryColor,),
          ],

          animationCurve: Curves.easeOutSine,

          animationDuration: Duration(
            milliseconds: 400
          ),
          onTap: (index){
            setState(() {
              selectedPage=index;
            });
          },
        ),

    );
  }
}
