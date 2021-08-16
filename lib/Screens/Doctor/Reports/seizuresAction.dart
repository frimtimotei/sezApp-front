import 'dart:convert';

import 'package:sezapp/api/doctor_api_service.dart';
import 'package:sezapp/model/Seizure.dart';

Future<List> getPatientWeekSezData(userId) async {
  var response = await apiWeekSezPatientFreq(userId);

  if (response.statusCode == 200) {
    var convertDataJason = jsonDecode(response.body);

    return convertDataJason;
  } else {
    throw Exception("Error to load data");
  }
}
Future<List> getPatientMonthSezData(userId) async {
  var response = await apiMonthSezPatientFreq(userId);

  if (response.statusCode == 200) {
    var convertDataJason = jsonDecode(response.body);

    return convertDataJason;
  } else {
    throw Exception("Error to load data");
  }
}


Future<List> getPatientYearSezData(userId) async {
  var response = await apiYearSezPatientFreq(userId);

  if (response.statusCode == 200) {
    var convertDataJason = jsonDecode(response.body);

    return convertDataJason;
  } else {
    throw Exception("Error to load data");
  }
}

Future<List<Seizure>> getPatientSeizures(patientId) async {
  var data = await apiGetAllPatientSeizures(patientId);
  List<Seizure> seizures = [];
  for (var i in data) {
    Seizure seizure = Seizure.fromJson(i);
    seizures.add(seizure);
  }

  return seizures.reversed.toList();
}