import 'package:flutter/material.dart';
import 'package:sezapp/constants.dart';


class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightColor,
      child: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("you are a patient"),


          ],
        ),
      ),

    );
  }
}
