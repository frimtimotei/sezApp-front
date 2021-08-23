import 'package:flutter/material.dart';
import 'package:sezapp/constants.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Center(
        child: Image.asset("assets/images/SezApp2_white.png",height: 80,),
      ),
    );
  }
}
