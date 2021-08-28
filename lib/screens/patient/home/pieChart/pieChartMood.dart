import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sezapp/api/seizureApiService.dart';
import 'package:sezapp/constants.dart';

import 'indicator.dart';

class PieChartMood extends StatefulWidget {
  final userId;
  const PieChartMood({Key key,this.userId}) : super(key: key);

  @override
  _PieChartMoodState createState() => _PieChartMoodState();
}

class _PieChartMoodState extends State<PieChartMood> {
  int touchedIndex = -1;
  Future moodSezFrequency;
  String biggest="";

  @override
  void initState() {
    moodSezFrequency = getMoodSezFreq(widget.userId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: FutureBuilder(
              future: moodSezFrequency,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data['bad']=='NaN'){
                    return Center(child: Text("No data"),);
                  }else{

                  return PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        if(mounted){
                        setState(() {

                          final desiredTouch =
                              pieTouchResponse.touchInput is! PointerExitEvent &&
                                  pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex =
                                pieTouchResponse.touchedSection.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        }
                            );}
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      startDegreeOffset: 10,
                      centerSpaceRadius: double.infinity,
                      sections: showingSections(snapshot),
                    ),
                    swapAnimationDuration: Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.linear,
                  );}
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),

        SizedBox(
          height: 14,
        ),

        Wrap(

          direction: Axis.horizontal,

          children: const <Widget>[

            Indicator(
              color: kRedBackColor,
              text: 'Bad',
              textColor: kRedTextColor,
            ),

            Indicator(
              color: kGreenBackColor,
              text: 'Good',
              textColor: kGreenTextColor,
            ),

            Indicator(
              color: kYellowBackColor,
              text: 'Normal',
              textColor: kYellowTextColor,
            ),


          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(AsyncSnapshot snapshot) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 90.0 : 70.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kRedBackColor,
            value: snapshot.data['bad'],
            title: snapshot.data['bad'].toString()+" %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: kRedTextColor),

          );
        case 1:
          return PieChartSectionData(
            color: kGreenBackColor,
            value: snapshot.data['good'],
            title: snapshot.data['good'].toString()+" %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: kGreenTextColor),
          );
        case 2:
          return PieChartSectionData(
            color: kYellowBackColor,
            value: snapshot.data['normal'],
            title: snapshot.data['normal'].toString()+" %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: kYellowTextColor),
          );

        default:
          throw Error();
      }
    });
  }

  Future getMoodSezFreq(userId) async {
    var response = await apiMoodSezFreq(userId);

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);

      return convertDataJason;
    } else
      throw Exception("Error to load");
  }
}
