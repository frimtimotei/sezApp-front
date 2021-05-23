import 'dart:convert';

import 'package:sezapp/model/medication_add_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String baseUrl='http://10.0.2.2:8080';

Future medicationRegister(MedicationRegisterModel medicationRegisterModel) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");

  final List<Map<String, dynamic>> reminders=[];

  for (int i=0;i< medicationRegisterModel.reminders.length;i++)
    {
      final Map<String, dynamic> reminder={
        "alarmTime": medicationRegisterModel.reminders[i].time,
        "howOften": medicationRegisterModel.reminders[i].howOften
      };

      reminders.add(reminder);

    }

  final Map<String, dynamic> seizureData = {
    'name': medicationRegisterModel.name,
    'dose_gram': medicationRegisterModel.dose,
    'start_date': medicationRegisterModel.startDate,
    'end_date': medicationRegisterModel.endDate,
    'set_reminder': medicationRegisterModel.setReminder,
    'reminders':reminders
  };

  String url = '$baseUrl/medication/create';
  final response = await http.post(url, headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },
      body: json.encode(seizureData));

  var convertDataJason = jsonDecode(response.body);
  return convertDataJason;
}