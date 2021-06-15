import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartMood.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartTrig.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartType.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class OtherInfoBox extends StatefulWidget {
  const OtherInfoBox({Key key}) : super(key: key);

  @override
  _OtherInfoBoxState createState() => _OtherInfoBoxState();
}

class _OtherInfoBoxState extends State<OtherInfoBox> {
  Future daysFromLastSeizure;

  @override
  void initState() {
    daysFromLastSeizure = getDaysFromLastSez();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Container(
          width: size.width * 0.42,
          height: 260,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, 0.2),
                    blurRadius: 20.0,
                    offset: Offset(0, 5))
              ]),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          margin:
              EdgeInsets.fromLTRB(size.width * 0.06, 10, size.width * 0.04, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                LineAwesomeIcons.calendar_with_day_focus,
                color: kPrimaryLightColor,
                size: 30,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  FutureBuilder(
                      future: daysFromLastSeizure,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(
                                fontSize: 30,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w800),
                          );
                        } else {
                          return Text(
                            "0",
                            style: TextStyle(
                                fontSize: 30,
                                color: kRedTextColor,
                                fontWeight: FontWeight.w800),
                          );
                        }
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Text(" days")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("from last Seizure "),
            ],
          ),
        ),



        //////////////////////////////////////////////////
        ///second
        Container(
          width: size.width * 0.42,
          height: 260,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, 0.2),
                    blurRadius: 20.0,
                    offset: Offset(0, 5))
              ]),
          padding: EdgeInsets.fromLTRB(13, 10, 13, 0),
          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
        )
      ],
    );
  }

  Column buildColumnMood(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              LineAwesomeIcons.smiling_face,
              color: kPrimaryLightColor,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text("Seizure mood", style: TextStyle(fontSize: size.width*0.03),)
          ],
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
        Row(
          children: [
            Icon(
              LineAwesomeIcons.brain,
              color: kPrimaryLightColor,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text("Seizure type",style: TextStyle(fontSize: size.width*0.03),)
          ],
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
        Row(
          children: [
            Icon(
              LineAwesomeIcons.flag,
              color: kPrimaryLightColor,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            Text("Trigger types",style: TextStyle(fontSize: size.width*0.03),)
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Center(child: PieChartTrig()),
      ],
    );
  }

  Future getDaysFromLastSez() async {
    var response = await apiDaysFromLastSez();

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);
      return convertDataJason;
    } else
      throw Exception("error to load");
  }
}
