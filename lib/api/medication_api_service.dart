import 'dart:convert';

import 'package:sezapp/model/medication_add_model.dart';
import 'package:sezapp/model/reminder_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String baseUrl='http://10.0.2.2:8080';

Future medicationRegister(MedicationRegisterModel medicationRegisterModel, List<Reminder>reminders) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");

  final List<Map<String, dynamic>> remindersData=[];

  for (int i=0;i< reminders.length;i++)
    {
      final Map<String, dynamic> reminderData={
        "alarmTime": reminders[i].time,
        "howOften": reminders[i].howOften
      };

      remindersData.add(reminderData);

    }

  final Map<String, dynamic> seizureData = {
    'name': medicationRegisterModel.name,
    'dose_gram': medicationRegisterModel.dose,
    'start_date': medicationRegisterModel.startDate,
    'end_date': medicationRegisterModel.endDate,
    'set_reminder': medicationRegisterModel.setReminder,
    'howOften':medicationRegisterModel.howOften,
    'reminders':remindersData
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


Future getAllMedications() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/medication/userMedication';
  final response = await http.get(url,headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);


  var convertDataJason= jsonDecode(response.body);
  return convertDataJason;

}


Future deleteMedication(int seizureId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/medication/delete/$seizureId' ;

  final response= await http.delete(url,headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);

  if(response.statusCode==200)
  {
    return true;
  }
  else{
    return false;
  }

}