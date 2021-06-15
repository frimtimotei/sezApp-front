import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Profile/edit_profile_page.dart';
import 'package:sezapp/Screens/Patient/Profile/profile_widget.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/conponents/buttonFull.dart';
import 'package:sezapp/conponents/detailsIconText.dart';

import 'package:sezapp/constants.dart';
import 'package:sezapp/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientUser extends StatefulWidget {
  @override
  _PatientUserState createState() => _PatientUserState();
}

class _PatientUserState extends State<PatientUser> {
  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove("jwt");

    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  Future<User> _loadUserInfo() async {
    var response = await userInfo();

    if (response.statusCode == 200) {
      response = jsonDecode(response.body);
    }
    return User.fromJson(response);
  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kLightColor,
      body: FutureBuilder(
          future: _loadUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final User activeUser = snapshot.data;
              return ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  ProfileWidget(
                      imagePath: activeUser.imageUrl,
                      callback: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => EditProfile(
                              currentUser: snapshot.data,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        activeUser.firstName + " " + activeUser.lastName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        activeUser.email,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => EditProfile(
                                currentUser: snapshot.data,
                              ),
                            ),
                          );
                        },
                        child: Text("Edit profile"),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          onPrimary: Colors.white,
                          primary: kPrimaryLightColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shadowColor: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      DetailsIconText(
                        mainText: userSexText(activeUser.sex),
                        prefix: "sex: ",
                        icon: sexIcon(activeUser.sex),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DetailsIconText(
                        mainText: activeUser.age,
                        prefix: "age: ",
                        icon: Icon(
                          LineAwesomeIcons.user_clock,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DetailsIconText(
                        mainText: "patient",
                        prefix: "role: ",
                        icon: Icon(
                          LineAwesomeIcons.user_tag,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Sing Out:"),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: _handleLogout,
                                child: Text("Sing Out"),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.3,
                                  shape: StadiumBorder(),
                                  enableFeedback: true,
                                  onPrimary: kPrimaryColor,
                                  primary: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 60),
                                  shadowColor: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Delete Account:"),
                              const SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Delete Account"),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.3,
                                  shape: StadiumBorder(),
                                  enableFeedback: true,
                                  onPrimary: kRedTextColor,
                                  primary: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 40),
                                  shadowColor: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "© SezApp Application @2021",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  String userSexText(String character) {
    if (character == "M")
      return "Masculine";
    else
      return "Feminine";
  }

  Icon sexIcon(String userSex) {
    if (userSex == "M")
      return Icon(
        LineAwesomeIcons.mars,
        color: kPrimaryColor,
      );
    else
      return Icon(
        LineAwesomeIcons.venus,
        color: kPrimaryColor,
      );
  }
}