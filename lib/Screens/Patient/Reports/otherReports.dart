import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartMood.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartTrig.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartType.dart';
import 'package:sezapp/api/doctor_api_service.dart';
import 'package:sezapp/api/seizure_api_service.dart';

import '../../../constants.dart';

class OtherReportsWidget extends StatefulWidget {
  const OtherReportsWidget({Key key}) : super(key: key);

  @override
  _OtherReportsWidgetState createState() => _OtherReportsWidgetState();
}

class _OtherReportsWidgetState extends State<OtherReportsWidget> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future daysFromLastSeizure;

    return Container(
      height: 420,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 0.2),
                blurRadius: 20.0,
                offset: Offset(0, 5))
          ]),

      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: ContainedTabBarView(
        tabs: [...[1, 2, 3].map((e) => Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(

              border: Border.all(color: Colors.grey[600]),
              borderRadius:
              BorderRadius.all(Radius.circular(8.0))),
        ))
            .toList()
        ],
        tabBarProperties: TabBarProperties(
          height: 32,
          width: size.width*0.12,
          position: TabBarPosition.bottom,
          indicator: ContainerTabIndicator(
            width: 12.0,
            height: 12.0,
            radius: BorderRadius.circular(9.0),
            color: kPrimaryLightColor,
          ),
        ),
        views: [buildColumnMood(size),
          buildColumnType(size),
          buildColumnTrig(size),
        ],
        onChange: (index){},
      ),
    );
  }

  Column buildColumnMood(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                LineAwesomeIcons.smiling_face,
                color: kPrimaryLightColor,
                size: 30,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text("Seizure mood", style: TextStyle(fontSize: 18),)
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Center(child: PieChartMood()),
      ],
    );
  }

  Column buildColumnType(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                LineAwesomeIcons.brain,
                color: kPrimaryLightColor,
                size: 30,
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text("Seizure type",style: TextStyle(fontSize: 18),)
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Center(child: PieChartType()),
      ],
    );
  }

  Column buildColumnTrig(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                LineAwesomeIcons.flag,
                color: kPrimaryLightColor,
                size: 30,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text("Trigger types",style: TextStyle(fontSize: 18),)
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Center(child: PieChartTrig()),
      ],
    );
  }



}
