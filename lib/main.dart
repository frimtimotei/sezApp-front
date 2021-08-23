import 'package:flutter/material.dart';


import 'package:sezapp/Screens/menu/doctorMenu.dart';
import 'package:sezapp/Screens/SingUp/singUp_screen.dart';

import 'package:sezapp/constants.dart';




import 'Screens/menu/patientMenu.dart';
import 'Screens/login/Landing.dart';
import 'Screens/login/loginScreen.dart';

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


          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: kPrimaryColor,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/':(context)=> Landing(),
          '/patientHome': (context)=> PatientMenu(),
          '/doctorHome': (context)=> DoctorMenu(),
          '/login': (context)=> LoginScreen(),
          '/singUp': (context)=> SingUpScreen()
          
        },

      ),
    );
  }
}

