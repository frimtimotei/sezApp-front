import 'package:http/http.dart' as http;
import 'package:sezapp/model/user/User.dart';
import 'package:sezapp/model/user/userLoginResponseModel.dart';
import 'dart:convert';

import 'package:sezapp/model/register_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../constants.dart';

class APIService {}



Future loginUser(LoginRequestModel loginRequestModel) async {
  final Map<String, dynamic> loginData = {
    'email': loginRequestModel.emil,
    'password': loginRequestModel.password
  };

  String url = '$baseUrl/users/login';
  final response = await http.post(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
      body: json.encode(loginData));

  return jsonDecode(response.body);
}

Future registerUser(RegisterRequestModel registerRequestModel) async {
  final Map<String, dynamic> loginData = {
    'first_name': registerRequestModel.firstName,
    'last_name': registerRequestModel.lastName,
    'email': registerRequestModel.email,
    'password': registerRequestModel.password,
    'age': registerRequestModel.age,
    'sex': registerRequestModel.sex,
    'role': registerRequestModel.role
  };

  String url = '$baseUrl/users/register';
  final response = await http.post(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "accept": "application/json"
      },
      body: json.encode(loginData));

  var convertDataJason = jsonDecode(response.body);
  return convertDataJason;
}

Future userInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/users/me';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
  );

  return response;
}

Future apiUploadUserPicture(String imagePath) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/users/me/updateImage';

  final request = new http.MultipartRequest("POST", Uri.parse(url));

  request.headers.addAll({
    'Content-Type': 'application/json',
    "accept": "application/json",
    'Authorization': "Bearer " + jwt
  });
  request.files.add(await http.MultipartFile.fromPath(
    'file',
    imagePath,
  ));
  request.send().then((response) {
    if (response.statusCode == 200)
      return true;
    else
      return false;
  });
}


Future apiUpdateUserInfo(User user) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  final Map<String, dynamic> updateData = {
    'first_name': user.firstName,
    'last_name': user.lastName,
    'email': user.email,
    'age': user.age,
    'sex': user.sex,
  };

  String url = '$baseUrl/users/me/update';
  final response = await http.post(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "accept": "application/json",
        'Authorization': "Bearer " + jwt
      },
      body: json.encode(updateData));

  var convertDataJason = jsonDecode(response.body);
  return convertDataJason;
}


Future apiGetAllUsersChat()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");

  String url = '$baseUrl/users/allContactsChat';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
  );

  return jsonDecode(response.body);

}



Future apiGetAllRoomChat(String activeUserId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");

  String url = '$baseUrl/users/allContactsRoomChat/$activeUserId';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      "accept": "application/json",
      'Authorization': "Bearer " + jwt
    },
  );

  return jsonDecode(response.body);

}




