import 'dart:convert';

import 'package:sezapp/model/seizure_add_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


  String baseUrl='http://10.0.2.2:8080';



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
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
        body: json.encode(seizureData));

    var convertDataJason = jsonDecode(response.body);
    return convertDataJason;
  }

  Future getAllSeizures() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    String url = '$baseUrl/seizure/userSeizures';
    final response = await http.get(url,headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);


    var convertDataJason= jsonDecode(response.body);
    return convertDataJason;

  }


  Future deleteSeizure(int seizureId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    String url = '$baseUrl/seizure/delete/$seizureId' ;

    final response= await http.delete(url,headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);

    if(response.statusCode==200)
      {
        return true;
      }
    else{
        return false;
    }

  }

Future weekSezFreq()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/weekSezFrequency';

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

Future monthSezFreq()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/monthSezFrequency';

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}


Future yearSezFreq()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/seizure/yearSezFrequency';

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  },);

  return response;
}

