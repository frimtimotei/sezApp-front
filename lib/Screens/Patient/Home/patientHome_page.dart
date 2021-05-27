import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sezapp/Screens/Patient/Home/otherInfoBox.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartMood.dart';
import 'package:sezapp/Screens/Patient/Home/reminderBox.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/User.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:sezapp/model/reminder_model.dart';

import 'calendar.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User activeUser = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightColor,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: kLightColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal:size.width*0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi! " + activeUser.firstName,
                      style: TextStyle(
                          fontSize: 30,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "how are you feeling today?",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              CustomCalendar(),

             ReminderBox(),


             OtherInfoBox(),





            ],



          ),
        ),
      ),
    );

  }


}
