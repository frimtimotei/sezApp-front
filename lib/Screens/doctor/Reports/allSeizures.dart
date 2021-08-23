import 'package:flutter/material.dart';
import 'package:sezapp/Screens/Patient/Reports/Seizures/list_seizures.dart';
import 'package:sezapp/components/customAppBar.dart';
class AllSeizuresDoctorPage extends StatelessWidget {
  final patientId;
  const AllSeizuresDoctorPage({Key key,this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(title: "All Seizures"),
      ),
      body: AllSeizures(userId:patientId ),
    );


  }
}
