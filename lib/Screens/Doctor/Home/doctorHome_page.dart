import 'package:flutter/material.dart';
import 'package:sezapp/Screens/Doctor/Home/calendar.dart';
import 'package:sezapp/Screens/Doctor/Home/listOfPatients.dart';
import 'package:sezapp/model/user/User.dart';

import '../../../constants.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key key}) : super(key: key);

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    final User activeUser = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightColor,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi! " + activeUser.firstName,
                style: TextStyle(
                    fontSize: 25,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "how are you feeling today?",
                style: TextStyle(
                    fontSize: 12 ,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: kLightColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(
                height: 10,
              ),
              CustomDoctorCalendar(),
              // ReminderBox(),
              // OtherInfoBox(),
              SizedBox(
                height: 30,
              ),

              SizedBox(
                height: 300,
                  child: ListOfPatientsHome()),

            ],
          ),
        ),
      ),
    );
  }
  }

