import 'package:flutter/material.dart';
import 'package:sezapp/Screens/Patient/Reports/chart_seizures.dart';
import 'package:sezapp/Screens/Patient/Reports/list_seizures.dart';
import 'package:sezapp/model/Seizure.dart';

import '../../../constants.dart';

class ReportsHome extends StatefulWidget {
 final Future<List<Seizure>> seizures;
  const ReportsHome({Key key, @required this.seizures}) : super(key: key);

  @override
  _ReportsHomeState createState() => _ReportsHomeState();
}

class _ReportsHomeState extends State<ReportsHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,

      child: Scaffold(appBar: PreferredSize(
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
            Tab(text: "Graphs",),
            Tab(text: "Seizures",),
            Tab(text: "Medications",)
          ],),
        ),

      ),
        body: TabBarView(children: [
          WeekSeizureFrequency(),
          AllSeizures(),
          Text("aaaaSd"),

        ],

        ),
      ),

    );
  }
}
