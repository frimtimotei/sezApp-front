import 'dart:convert';

import 'package:sezapp/model/MedicationRegisterModel.dart';
import 'package:sezapp/model/Reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future medicationRegister(MedicationRegisterModel medicationRegisterModel,
    List<Reminder> reminders, userId, userName, doctorName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");

  final List<Map<String, dynamic>> remindersData = [];

  for (int i = 0; i < reminders.length; i++) {
    final Map<String, dynamic> reminderData = {
      "alarmTime": reminders[i].time,
      "howOften": reminders[i].howOften
    };

    remindersData.add(reminderData);
  }

  if(userId==null|| doctorName==null) {

    final Map<String, dynamic> seizureData = {
      'name': medicationRegisterModel.name,
      'dose_gram': medicationRegisterModel.dose,
      'start_date': medicationRegisterModel.startDate,
      'end_date': medicationRegisterModel.endDate,
      'set_reminder': medicationRegisterModel.setReminder,
      "addedBy": userName.toString(),
      'howOften': medicationRegisterModel.howOften,
      'reminders': remindersData
    };

    String url = '$baseUrl/medication/create';
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "accept": "application/json",
          'Authorization': "Bearer " + jwt
        },
        body: json.encode(seizureData));

    var convertDataJason = jsonDecode(response.body);
    return convertDataJason;
  }else
    {
      final Map<String, dynamic> seizureData = {
        'name': medicationRegisterModel.name,
        'dose_gram': medicationRegisterModel.dose,
        'start_date': medicationRegisterModel.startDate,
        'end_date': medicationRegisterModel.endDate,
        'set_reminder': medicationRegisterModel.setReminder,
        "addedBy": doctorName,
        'howOften': medicationRegisterModel.howOften,
        'reminders': remindersData
      };
      String url = '$baseUrl/doctor/addMedication/$userId';
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            "accept": "application/json",
            'Authorization': "Bearer " + jwt
          },
          body: json.encode(seizureData));

      var convertDataJason = jsonDecode(response.body);
      return convertDataJason;
    }
}

Future getAllMedications(userId) async {
  String url;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  if(userId==null) {
    url = '$baseUrl/medication/userMedication';
  }else{

     url = '$baseUrl/doctor/patientMedication/$userId';


  }

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
  );

  var convertDataJason = jsonDecode(response.body);
  return convertDataJason;
}

Future deleteMedication(int medicationId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/medication/delete/$medicationId';

  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future apiGetAllRemindersMedications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/users/allMedicationReminders';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
  );

  var convertDataJason = jsonDecode(response.body);
  return convertDataJason;
}


// Future medicationDoctorRegister(MedicationRegisterModel medicationRegisterModel,
//     List<Reminder> reminders, userID) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String jwt = prefs.getString("jwt");
//
//   final List<Map<String, dynamic>> remindersData = [];
//
//   for (int i = 0; i < reminders.length; i++) {
//     final Map<String, dynamic> reminderData = {
//       "alarmTime": reminders[i].time,
//       "howOften": reminders[i].howOften
//     };
//
//     remindersData.add(reminderData);
//   }
//
//   final Map<String, dynamic> seizureData = {
//     'name': medicationRegisterModel.name,
//     'dose_gram': medicationRegisterModel.dose,
//     'start_date': medicationRegisterModel.startDate,
//     'end_date': medicationRegisterModel.endDate,
//     'set_reminder': medicationRegisterModel.setReminder,
//     'howOften': medicationRegisterModel.howOften,
//     'reminders': remindersData
//   };
//
//   String url = '$baseUrl/doctor/addMedication/$userID';
//   final response = await http.post(Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         "accept": "application/json",
//         'Authorization': "Bearer " + jwt
//       },
//       body: json.encode(seizureData));
//
//   var convertDataJason = jsonDecode(response.body);
//   return convertDataJason;
// }
