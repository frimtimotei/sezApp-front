import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Add/addDoctor.dart';
import 'package:sezapp/Screens/Patient/Chat/messageRoom.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartMood.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartTrig.dart';
import 'package:sezapp/Screens/Patient/Home/pieChart/pieChartType.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:sezapp/model/Doctor.dart';
import 'package:sezapp/model/user/User.dart';
import 'package:sezapp/model/user/UserChatContactDTO.dart';

class OtherInfoBox extends StatefulWidget {
  const OtherInfoBox({Key key}) : super(key: key);

  @override
  _OtherInfoBoxState createState() => _OtherInfoBoxState();
}

class _OtherInfoBoxState extends State<OtherInfoBox> {
  Future daysFromLastSeizure;
  Future doctor;

  @override
  void initState() {
    daysFromLastSeizure = getDaysFromLastSez();
    doctor = getCurrentDoctor();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User activeUser = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: 5,),
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, 0.2),
                    blurRadius: 20.0,
                    offset: Offset(0, 5))
              ]),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 0,
              ),
              Row(
                children: [
                  FutureBuilder(
                      future: daysFromLastSeizure,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("  days from last seizure")
                                ],
                              ),
                              leading: returnIcon(snapshot.data),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ],
          ),
        ),

        //////////////////////////////////////////////////
        ///second
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                "Your current doctor",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: 85,
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, 0.2),
                    blurRadius: 20.0,
                    offset: Offset(0, 5))
              ]),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                  future: doctor,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != 0) {
                      return Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                sentToChat(snapshot.data, activeUser, context);
                              },
                              child: Ink(
                                  child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: kPrimaryLightColor,
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      checkImagePath(snapshot.data.imageUrl)),
                                ),
                                title: Text(
                                  snapshot.data.firstName +
                                      " " +
                                      snapshot.data.lastName,
                                  style: TextStyle(fontSize: 17),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text("age: " + snapshot.data.age),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "• your Doctor",
                                      style:
                                          TextStyle(color: Colors.orangeAccent),
                                    )
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => AddDoctorPage()
                                  ));
                            },
                            child: ListTile(
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: kPrimaryLightColor,
                              ),
                              title: Text("No doctor selected"),
                              subtitle: Text("Select your doctor"),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Future getDaysFromLastSez() async {
    var response = await apiDaysFromLastSez();

    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);
      return convertDataJason;
    } else
      throw Exception("error to load");
  }

  Future getCurrentDoctor() async {
    var response = await apiGetUserCurrentDoctorChat();
    if (response.statusCode == 200) {
      var convertDataJason = jsonDecode(response.body);
      return Doctor.fromJson(convertDataJason);
    } else {
      var convertDataJason = jsonDecode(response.body);
      print(convertDataJason['status'].toString());
      return 0;
    }
  }

  void sentToChat(data, activeUser, context) {
    UserChatContactDTO senderUser = new UserChatContactDTO();
    senderUser.id = data.id;
    senderUser.firstName = data.firstName;
    senderUser.lastName = data.lastName;
    senderUser.imageUrl = data.imageUrl;
    senderUser.role = "doctor";

    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => MessageRoom(
            senderUser: senderUser,
            activeUser: activeUser,
          ),
        ));
  }

  returnIcon(data) {
    if (data > 4) {
      return Icon(
        Icons.arrow_upward,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.arrow_downward_rounded,
        color: Colors.red,
      );
    }
  }
}
