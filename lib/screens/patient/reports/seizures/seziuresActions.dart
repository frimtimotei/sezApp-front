import 'dart:convert';

import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/model/Seizure.dart';

Future<List<Seizure>> getSeizures(userId) async {
  var data = await apiGetAllSeizures(userId);
  List<Seizure> seizures = [];
  for (var i in data) {
    Seizure seizure = Seizure.fromJson(i);
    seizures.add(seizure);
  }

  return seizures.reversed.toList();
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

