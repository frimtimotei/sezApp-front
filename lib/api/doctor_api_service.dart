import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

Future apiGetAllPatients() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/doctor/getPatients';
  final response = await http.get(Uri.parse(url),headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);


  var convertDataJason= jsonDecode(response.body);
  return convertDataJason;

}




Future apiWeekSezPatientFreq(patientID)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/doctor/weekSezFrequency/$patientID';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiMonthSezPatientFreq(patientId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/doctor/monthSezFrequency/$patientId';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}


Future apiYearSezPatientFreq(patientId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/doctor/yearSezFrequency/$patientId';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}


Future apiPatientDaysFromLastSez(patientId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/doctor/daysFromLastSez/$patientId';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiMoodSezFreq(patientId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/doctor/moodSezFrequency/$patientId';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiTypeSezFreq(patientId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/doctor/typeSezFrequency/$patientId';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiTrigSezFreq(patientId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/trigSezFrequency';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}
