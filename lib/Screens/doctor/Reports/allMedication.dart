import 'package:flutter/material.dart';

import 'package:sezapp/Screens/Patient/Reports/Medication/list_medication.dart';
import 'package:sezapp/components/customAppBar.dart';
class AllMedicationDoctorPage extends StatelessWidget {
  final patientId;
  const AllMedicationDoctorPage({Key key,this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(title: "All Medication"),
      ),
      body:  AllMedication(userId: patientId),
    );
  }
}
