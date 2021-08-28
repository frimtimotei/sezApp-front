import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';


Future apiFindChatMessage(id) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/messages/$id';


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


Future apiFindAllChatMessage(senderId, recipientId) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  String url = '$baseUrl/messages/$senderId/$recipientId';


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



