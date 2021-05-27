import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/constants.dart';

import 'indicator.dart';

class PieChartTrig extends StatefulWidget {
  const PieChartTrig({Key key}) : super(key: key);

  @override
  _PieChartTrigState createState() => _PieChartTrigState();
}

class _PieChartTrigState extends State<PieChartTrig> {
  int touchedIndex = -1;
  Future trigSezFrequency;
  String biggest;
  @override
  void initState() {
    trigSezFrequency = getTypeSezFreq();
    biggest="";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 140,
          width: 140,
          child: FutureBuilder(
              future: trigSezFrequency,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        if(mounted)
                        setState(() {
                          biggest=snapshot.data[0]["biggest"];
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
                        });
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
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),

        SizedBox(
          height: 5,
        ) ,

        Row(

          children: <Widget>[
            Text("Most:", style: TextStyle(fontSize: 10),),
            Indicator(
              color: kRedBackColor,
              text: biggest,
              textColor: kRedTextColor,
            ),

          ],
        )


      ],
    );
  }

  List<PieChartSectionData> showingSections(AsyncSnapshot snapshot) {
    return List.generate(snapshot.data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 12.0;
      final radius = isTouched ? 65.0 : 50.0;
      final text= isTouched ? " " : snapshot.data[i]["freq"].toString()+" %";
      final text2= isTouched ?  snapshot.data[i]["name"] +"\n"+ snapshot.data[i]["freq"].toString()+" %": "";
      final textColor= kListTextColors[i];

      return PieChartSectionData(
        color: kListBackColors[i],
        value: snapshot.data[i]["freq"],
        title: text,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: kListTextColors[i]),
        badgeWidget: Text(text2, style: TextStyle(fontSize: 15,color: textColor,fontWeight: FontWeight.w800),),

      );

    });





  }

  Future getTypeSezFreq() async {
    var response = await apiTrigSezFreq();

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);

      return convertDataJason;
    } else
      throw Exception("Error to load");
  }
}
