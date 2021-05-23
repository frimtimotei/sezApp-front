


import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

void saveAndRedirectToHome(var response, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();



  await prefs.setInt("id", response['id']);
  await prefs.setInt("roleId", response['roles'][0]['id']);
  await prefs.setString("jwt", response['jwt']);


  Navigator.pushNamedAndRemoveUntil(
      context, '/', ModalRoute.withName('/'),
  );


}