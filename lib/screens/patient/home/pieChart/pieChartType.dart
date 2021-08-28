import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/screens/patient/home/pieChart/indicator.dart';

class PieChartType extends StatefulWidget {
  final userId;

  const PieChartType({Key key, this.userId}) : super(key: key);

  @override
  _PieChartTypeState createState() => _PieChartTypeState();
}

class _PieChartTypeState extends State<PieChartType> {
  int touchedIndex = -1;
  Future typeSezFrequency;

  @override
  void initState() {
    typeSezFrequency = getTypeSezFreq(widget.userId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      child: FutureBuilder(
          future: typeSezFrequency,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text("No data"),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: PieChart(
                        PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            if (mounted) {
                              setState(() {
                                final desiredTouch = pieTouchResponse.touchInput
                                        is! PointerExitEvent &&
                                    pieTouchResponse.touchInput
                                        is! PointerUpEvent;
                                if (desiredTouch &&
                                    pieTouchResponse.touchedSection != null) {
                                  touchedIndex = pieTouchResponse
                                      .touchedSection.touchedSectionIndex;
                                } else {
                                  touchedIndex = -1;
                                }
                              });
                            }
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          startDegreeOffset: 10,
                          centerSpaceRadius: double.infinity,
                          sections: showingSections(snapshot, size),
                        ),
                        swapAnimationDuration: Duration(milliseconds: 150),
                        swapAnimationCurve: Curves.linear,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Most:",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 16),
                          ),
                          Indicator(
                            color: kPrimaryLightColor,
                            text: snapshot.data[0]["biggest"],
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  List<PieChartSectionData> showingSections(AsyncSnapshot snapshot, Size size) {
    return List.generate(snapshot.data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 16.0;
      final radius = isTouched ? 90.0 : 70.0;
      final text = isTouched ? "" : snapshot.data[i]["freq"].toString() + "%";
      final text2 = isTouched
          ? snapshot.data[i]["name"] +
              "\n" +
              snapshot.data[i]["freq"].toString() +
              "%"
          : " ";
      final textColor = kListTextColors[i % 10];

      return PieChartSectionData(
        color: kListBackColors[i % 10],
        value: snapshot.data[i]["freq"],
        title: text,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: kListTextColors[i % 10]),
        badgeWidget: Text(
          text2,
          style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.w800),
        ),
      );
    });
  }

  Future getTypeSezFreq(userId) async {
    var response = await apiTypeSezFreq(userId);

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);

      return convertDataJason;
    } else
      throw Exception("Error to load");
  }
}
