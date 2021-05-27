import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/constants.dart';

class WeekSeizureFrequency extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeekSeizureFrequencyState();
}

class WeekSeizureFrequencyState extends State<WeekSeizureFrequency> {
  final Color barBackgroundColor = kLightColor;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  Future<List> freqData;
  Future<List> weekFreqData;
  Future<List> monthFreqData;
  Future<List> yearFreqData;

  int barList=7;

  bool weekSelected = true;
  bool monthSelected = false;
  bool yearSelected = false;

  String titleFreq = "Last Week";
  double maxY=6;
  double widthBar = 25;
  List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    weekFreqData = getWeekSezData();
    monthFreqData = getMonthSezData();
    yearFreqData=getYearSezData();

    freqData = weekFreqData;
  }

  @override
  Widget build(BuildContext context) {
    isSelected = [weekSelected, monthSelected, yearSelected];

    Size size = MediaQuery.of(context).size;
    return Container(
      color: kLightColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 450,

              child: Card(
                margin: EdgeInsets.all(15),
                elevation: 0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, 0.1),
                            blurRadius: 50.0,
                            offset: Offset(0, 15))
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Center(
                              ///// menu Week Month Year
                              child: ToggleButtons(
                                color: kPrimaryLightColor,
                                selectedColor: Colors.white,
                                selectedBorderColor: kPrimaryLightColor,
                                fillColor: kPrimaryLightColor,
                                splashColor: kPrimaryLightColor,
                                hoverColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                borderWidth: 1.3,
                                borderColor: kPrimaryLightColor,
                                constraints: BoxConstraints(minHeight: 36.0),
                                isSelected: isSelected,
                                highlightColor: Colors.transparent,
                                onPressed: (index) {
                                  // Respond to button selection


                                    if (index == 1) {
                                      setState(() {

                                      freqData = monthFreqData;
                                      weekSelected = false;
                                      monthSelected = true;
                                      yearSelected = false;
                                      maxY=10;
                                      titleFreq = "This Month";
                                      widthBar = 25;
                                      barList=7;
                                      });

                                    } else if (index == 0) {
                                      setState(() {

                                      freqData = weekFreqData;
                                      weekSelected = true;
                                      monthSelected = false;
                                      yearSelected = false;
                                      maxY=6;
                                      titleFreq = "Last Week";
                                      widthBar = 25;
                                      barList=7;
                                      });
                                    }else if (index == 2) {
                                      setState(() {

                                          freqData = yearFreqData;
                                          weekSelected = false;
                                          monthSelected = false;
                                          yearSelected = true;
                                          maxY = 20;
                                          titleFreq = "This Year";
                                          widthBar = size.width*0.04;
                                          barList = 12;
                                      });
                                    }



                                },
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      'Week',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text('Month',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text('Year',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              titleFreq,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Seizure frequency',
                              style: TextStyle(
                                  color: kPrimaryLightColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // ignore: missing_required_param
                            FutureBuilder<List>(

                                future: freqData,
                                builder: (context, snapshot) {
                                  if ((yearSelected && snapshot.hasData && snapshot.data.length>=12) || (!yearSelected && snapshot.hasData && snapshot.data.length >=7)) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: BarChart(
                                          mainBarData(snapshot),
                                          swapAnimationDuration: Duration(milliseconds: 350),
                                          swapAnimationCurve:
                                              Curves.linear, // Optional
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                }),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = kPrimaryLightColor,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 0.3 : y,
          colors: isTouched ? [kSecondaryColor] : [barColor],
          width: widthBar,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxY,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(AsyncSnapshot snapshot) {

        return List.generate(barList, (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, snapshot.data[0]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 1:
              return makeGroupData(1, snapshot.data[1]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 2:
              return makeGroupData(2, snapshot.data[2]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 3:
              return makeGroupData(3, snapshot.data[3]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 4:
              return makeGroupData(4, snapshot.data[4]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 5:
              return makeGroupData(5, snapshot.data[5]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 6:
              return makeGroupData(6, snapshot.data[6]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 7:
              return makeGroupData(7, snapshot.data[7]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 8:
              return makeGroupData(8, snapshot.data[8]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 9:
              return makeGroupData(9, snapshot.data[9]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 10:
              return makeGroupData(10, snapshot.data[10]['freq'].toDouble(),
                  isTouched: i == touchedIndex);
            case 11:
              return makeGroupData(11, snapshot.data[11]['freq'].toDouble(),
                  isTouched: i == touchedIndex);

            default:
              return throw Error();
          }
        });
      }

  BarChartData mainBarData(AsyncSnapshot snapshot) {
    return BarChartData(
      maxY: maxY,

      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String clickInfo;
              if (weekSelected) {
                switch (group.x.toInt()) {
                  case 0:
                    clickInfo = 'Monday ' + snapshot.data[0]['date'];
                    break;
                  case 1:
                    clickInfo = 'Tuesday ' + snapshot.data[1]['date'];
                    break;
                  case 2:
                    clickInfo = 'Wednesday ' + snapshot.data[2]['date'];
                    break;
                  case 3:
                    clickInfo = 'Thursday ' + snapshot.data[3]['date'];
                    break;
                  case 4:
                    clickInfo = 'Friday ' + snapshot.data[4]['date'];
                    break;
                  case 5:
                    clickInfo = 'Saturday ' + snapshot.data[5]['date'];
                    break;
                  case 6:
                    clickInfo = 'Sunday ' + snapshot.data[6]['date'];
                    break;
                  default:
                    throw Error();
                }
              }
              if (monthSelected) {
                switch (group.x.toInt()) {
                  case 0:
                    clickInfo = 'From ' +
                        snapshot.data[0]['startDate'] +
                        ' To ' +
                        snapshot.data[0]['endDate'];
                    break;
                  case 1:
                    clickInfo = 'From ' +
                        snapshot.data[1]['startDate'] +
                        ' To ' +
                        snapshot.data[1]['endDate'];
                    break;
                  case 2:
                    clickInfo = 'From ' +
                        snapshot.data[2]['startDate'] +
                        ' To ' +
                        snapshot.data[2]['endDate'];
                    break;
                  case 3:
                    clickInfo = 'From ' +
                        snapshot.data[3]['startDate'] +
                        ' To ' +
                        snapshot.data[3]['endDate'];
                    break;
                  case 4:
                    clickInfo = 'From ' +
                        snapshot.data[4]['startDate'] +
                        ' To ' +
                        snapshot.data[4]['endDate'];
                    break;
                  case 5:
                    clickInfo = 'From ' +
                        snapshot.data[5]['startDate'] +
                        ' To ' +
                        snapshot.data[5]['endDate'];
                    break;
                  case 6:
                    clickInfo = 'From ' +
                        snapshot.data[6]['startDate'] +
                        ' To ' +
                        snapshot.data[6]['endDate'];
                    break;
                  default:
                    throw Error();
                }


              }
              if (yearSelected) {
                switch (group.x.toInt()) {
                  case 0:
                    clickInfo = snapshot.data[0]['month'];
                    break;
                  case 1:
                    clickInfo = snapshot.data[1]['month'];
                    break;
                  case 2:
                    clickInfo = snapshot.data[2]['month'];
                    break;
                  case 3:
                    clickInfo = snapshot.data[3]['month'];
                    break;
                  case 4:
                    clickInfo = snapshot.data[4]['month'];
                    break;
                  case 5:
                    clickInfo = snapshot.data[5]['month'];
                    break;
                  case 6:
                    clickInfo = snapshot.data[6]['month'];
                    break;
                  case 7:
                    clickInfo = snapshot.data[7]['month'];
                    break;
                  case 8:
                    clickInfo = snapshot.data[8]['month'];
                    break;
                  case 9:
                    clickInfo = snapshot.data[9]['month'];
                    break;
                  case 10:
                    clickInfo = snapshot.data[10]['month'];
                    break;
                  case 11:
                    clickInfo = snapshot.data[11]['month'];
                    break;
                  default:
                    throw Error();
                }
              }

              return BarTooltipItem(
                clickInfo + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Seizures: " + (rod.y.toInt()).toString(),
                    style: TextStyle(
                      color: kLightColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            if (monthSelected) {

              switch (value.toInt()) {
                case 0:
                  return '1-4';
                case 1:
                  return '5-8';
                case 2:
                  return '9-12';
                case 3:
                  return '13-16';
                case 4:
                  return '17-20';
                case 5:
                  return '21-24';
                case 6:
                  return '25+';
                default:
                  return '';
              }
            }
            if (yearSelected) {

              switch (value.toInt()) {
                case 0:
                  return 'J';
                case 1:
                  return 'F';
                case 2:
                  return 'M';
                case 3:
                  return 'A';
                case 4:
                  return 'M';
                case 5:
                  return 'J';
                case 6:
                  return 'J';
                case 7:
                  return 'A';
                case 8:
                  return 'S';
                case 9:
                  return 'O';
                case 10:
                  return 'N';
                case 11:
                  return 'D';
                default:
                  return '';
              }
            }
            else{
              switch (value.toInt()) {
                case 0:
                  return 'M';
                case 1:
                  return 'T';
                case 2:
                  return 'W';
                case 3:
                  return 'T';
                case 4:
                  return 'F';
                case 5:
                  return 'S';
                case 6:
                  return 'S';
                case 7:
                  return 'S';
                default:
                  return '';
              }
            }

          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 20,
          reservedSize: 10,
          getTitles: (value) {
            if(value%2==0)
              return value.toInt().toString();
            else {
              return '';
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(snapshot),
    );
  }

  Future<List> getWeekSezData() async {
    var response = await apiWeekSezFreq();

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);

      return convertDataJason;
    } else {
      throw Exception("Error to load data");
    }
  }

  Future<List> getMonthSezData() async {
    var response = await apiMonthSezFreq();

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);

      return convertDataJason;
    } else {
      throw Exception("Error to load data");
    }
  }

  Future<List> getYearSezData() async {
    var response = await apiYearSezFreq();

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);

      return convertDataJason;
    } else {
      throw Exception("Error to load data");
    }
  }
}
