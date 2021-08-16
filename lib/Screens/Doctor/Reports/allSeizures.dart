import 'package:flutter/material.dart';
import 'package:sezapp/Screens/Doctor/Reports/seizuresAction.dart';
import 'package:sezapp/Screens/Patient/Reports/Seizures/list_seizures.dart';
import 'package:sezapp/api/doctor_api_service.dart';
import 'package:sezapp/conponents/appBar.dart';
class AllSeizuresDoctorPage extends StatelessWidget {
  final patientId;
  const AllSeizuresDoctorPage({Key key,this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAAppBar(title: "All Seizures"),
      ),
      body: AllSeizures(apiSez: getPatientSeizures(patientId) ),
    );


  }
}
