import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Doctor/Home/doctorHome_page.dart';
import 'package:sezapp/Screens/Patient/Chat/chatHome.dart';
import 'package:sezapp/Screens/Patient/Profile/patientUser_page.dart';
import 'package:sezapp/conponents/splashScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();

}

class _DoctorHomeState extends State<DoctorHome> {


  int selectedPage=0;
  final _pageOptions=[
    DoctorHomePage(),
    ChatHome(),
    SplashScreen(),
    PatientUser()

  ];
  @override
  Widget build(BuildContext context) {
    //final User args = ModalRoute.of(context).settings.arguments;


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
