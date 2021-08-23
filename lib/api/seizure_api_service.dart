import 'dart:convert';

import 'package:sezapp/model/SeizureRegisterModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';






  Future seizureRegister(SeizureRegisterModel seizureRequestModel) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    final Map<String, dynamic> seizureData = {
      'date': seizureRequestModel.date,
      'start_at': seizureRequestModel.startAt,
      'duration': seizureRequestModel.duration,
      'sez_trigger': seizureRequestModel.sezTrigger,
      'activity': seizureRequestModel.activity,
      'location': seizureRequestModel.location,
      'type': seizureRequestModel.type,
      'mood': seizureRequestModel.mood,
      'notes': seizureRequestModel.notes
    };


    String url = '$baseUrl/seizure/create';
    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
        body: json.encode(seizureData));

    var convertDataJason = jsonDecode(response.body);
    return convertDataJason;
  }

  Future apiGetAllSeizures(userId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    String url;

    if(userId==null){
      url = '$baseUrl/seizure/userSeizures';
    }else{
      url = '$baseUrl/doctor/patientSeizures/$userId';
    }

    final response = await http.get(Uri.parse(url),headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);


    var convertDataJason= jsonDecode(response.body);
    return convertDataJason;

  }


  Future apiDeleteSeizure(int seizureId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    String url = '$baseUrl/seizure/delete/$seizureId' ;

    final response= await http.delete(Uri.parse(url),headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);

    if(response.statusCode==200)
      {
        return true;
      }
    else{
        return false;
    }

  }

Future apiWeekSezFreq()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/weekSezFrequency';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiMonthSezFreq()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/monthSezFrequency';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}


Future apiYearSezFreq()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/yearSezFrequency';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}


Future apiDaysFromLastSez()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/daysFromLastSez';

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiMoodSezFreq(userId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url;

  if(userId==null)
    url = '$baseUrl/seizure/moodSezFrequency';
  else{
    url = '$baseUrl/doctor/moodSezFrequency/$userId';
  }
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiTypeSezFreq(userId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url;

  if(userId==null)
    url = '$baseUrl/seizure/typeSezFrequency';
  else{
    url = '$baseUrl/doctor/typeSezFrequency/$userId';
  }

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future apiTrigSezFreq(userId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url ;

  if(userId==null)
    url = '$baseUrl/seizure/trigSezFrequency';
  else{
    url = '$baseUrl/doctor/trigSezFrequency/$userId';
  }
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}


