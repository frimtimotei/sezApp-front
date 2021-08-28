import 'package:flutter/material.dart';
import 'package:sezapp/screens/patient/reports/chartSeizures.dart';
import 'package:sezapp/screens/patient/reports/medication/listMedications.dart';
import 'package:sezapp/screens/patient/reports/pieChart.dart';
import 'package:sezapp/screens/patient/reports/seizures/listSeizures.dart';

import '../../../constants.dart';
import 'seizures/seziuresActions.dart';

class ReportsHome extends StatefulWidget {
  const ReportsHome({Key key}) : super(key: key);

  @override
  _ReportsHomeState createState() => _ReportsHomeState();
}

class _ReportsHomeState extends State<ReportsHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            centerTitle: true,
            title: Text(
              "Reports",
              style: TextStyle(
                fontSize: 20,
                color: kPrimaryColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            bottom: TabBar(
              indicatorColor: kPrimaryLightColor,
              labelColor: kPrimaryLightColor,
              unselectedLabelColor: kPrimaryColor,
              tabs: [
                Tab(
                  text: "Graphs",
                ),
                Tab(
                  text: "Seizures",
                ),
                Tab(
                  text: "Medications",
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            GraphsPage(),
            AllSeizures(),
            AllMedication(),
          ],
        ),
      ),
    );
  }
}

class GraphsPage extends StatelessWidget {
  const GraphsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            WeekSeizureFrequency(
              weekFreqData: getWeekSezData(),
              monthFreqData: getMonthSezData(),
              yearFreqData: getYearSezData(),
            ),
            PieChartWidget(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
