import 'package:flutter/material.dart';
import 'package:sezapp/screens/menu/doctorMenu.dart';
import 'package:sezapp/screens/singUp/singUp_screen.dart';
import 'package:sezapp/constants.dart';

import 'screens/login/landing.dart';
import 'screens/login/loginScreen.dart';
import 'screens/menu/patientMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        title: 'Flutter Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Ubuntu",
          canvasColor: Colors.white,
          indicatorColor: kPrimaryLightColor,
          shadowColor: kPrimaryColor,


          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => Landing(),
          '/patientHome': (context) => PatientMenu(),
          '/doctorHome': (context) => DoctorMenu(),
          '/login': (context) => LoginScreen(),
          '/singUp': (context) => SingUpScreen()
        },
      ),
    );
  }
}
