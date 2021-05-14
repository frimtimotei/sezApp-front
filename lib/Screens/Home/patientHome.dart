import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Add/add_page.dart';
import 'package:sezapp/Screens/Patient/Reports/reports_home.dart';
import 'package:sezapp/Screens/Patient/Reports/seziuresActions.dart';
import 'package:sezapp/Screens/Patient/patientHome_page.dart';
import 'package:sezapp/Screens/Patient/patientUser_page.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/Seizure.dart';
import 'package:sezapp/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove("roleId");
    prefs.remove("jwt");

    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }





  int selectedPage=0;
  final _pageOptions=[
      PatientHomePage(),
      PatientHomePage(),
      PatientAddPage(),
      ReportsHome(seizures: getSeizures(),),
      PatientUser()

  ];
  @override
  Widget build(BuildContext context) {
    final User args = ModalRoute.of(context).settings.arguments;


    return Scaffold(
         body: _pageOptions[selectedPage],

        //     child: Column(
        //
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         Text("you are a patient"),
        //         Text("Welcome back " + args.firstName + "!"),
        //         Text("Last login was on " + args.lastName),
        //         Text("Your Email is  " + args.email),
        //         RaisedButton(
        //           onPressed: _handleLogout,
        //           child: Text("Logout"),
        //         )
        //       ],
        //     ),

        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: kLightColor,
          height: 65,
          items: <Widget>[
            Icon(LineAwesomeIcons.home,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.envelope,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.plus,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.bar_chart_1,size: 30,color: kPrimaryColor,),
            Icon(LineAwesomeIcons.user,size: 30,color: kPrimaryColor,),
          ],

          animationDuration: Duration(
            milliseconds: 200
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
