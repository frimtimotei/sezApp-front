import 'package:http/http.dart' as http;
import 'package:sezapp/model/login_model.dart';
import 'dart:convert';

import 'package:sezapp/model/register_model.dart';
import 'package:sezapp/model/seizureRegister_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class APIService {
}
String baseUrl='http://10.0.2.2:8080';


  Future loginUser(LoginRequestModel loginRequestModel) async{

      final Map<String, dynamic> loginData = {

        'email': loginRequestModel.emil,
        'password': loginRequestModel.password

      };

      String url='$baseUrl/users/login';
      final response = await http.post(url,headers: {'Content-Type': 'application/json',"accept" : "application/json" },
          body: json.encode(loginData));

      var convertDataJason= jsonDecode(response.body);
      return convertDataJason;
}

Future registerUser(RegisterRequestModel registerRequestModel) async{

  final Map<String, dynamic> loginData = {
    'first_name': registerRequestModel.firstName,
    'last_name': registerRequestModel.lastName,
     'email': registerRequestModel.email,
    'password': registerRequestModel.password,
    'age':registerRequestModel.age,
    'sex': registerRequestModel.sex,
    'role': registerRequestModel.role

  };

  String url='$baseUrl/users/register';
  final response = await http.post(url,headers: {'Content-Type': 'application/json',"accept" : "application/json" },
      body: json.encode(loginData));

  var convertDataJason= jsonDecode(response.body);
  return convertDataJason;
}


Future userInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt= prefs.getString("jwt");
    String url='$baseUrl/users/me';
    final response = await http.get(url,headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},);

    print(response.body);
    var convertDataJason= jsonDecode(response.body);
    return convertDataJason;
}


Future seizureRegister(SeizureRequestModel seizureRequestModel) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt= prefs.getString("jwt");

  final Map<String, dynamic> seizureData = {
    'date': seizureRequestModel.date,
    'start_at': seizureRequestModel.startAt,
    'end_at': seizureRequestModel.endAt,
    'sez_trigger': seizureRequestModel.sezTrigger,
    'activity':seizureRequestModel.activity,
    'location': seizureRequestModel.location,
    'type': seizureRequestModel.location,
    'notes': seizureRequestModel.notes

  };



  String url='$baseUrl/seizure/create';
  final response = await http.post(url,headers: {'Content-Type': 'application/json',"accept" : "application/json", 'Authorization': "Bearer "+ jwt},
      body: json.encode(seizureData));

  var convertDataJason= jsonDecode(response.body);
  return convertDataJason;
}





