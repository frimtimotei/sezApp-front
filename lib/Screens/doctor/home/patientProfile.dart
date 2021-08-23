import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sezapp/Screens/doctor/Reports/allMedication.dart';
import 'package:sezapp/Screens/doctor/Reports/allSeizures.dart';
import 'package:sezapp/Screens/doctor/Reports/seizuresAction.dart';
import 'package:sezapp/Screens/Patient/Add/addMedication.dart';
import 'package:sezapp/Screens/Patient/Chat/messageRoom.dart';
import 'package:sezapp/Screens/Patient/Reports/chart_seizures.dart';
import 'package:sezapp/Screens/Patient/Reports/pie_chart.dart';
import 'package:sezapp/components/customAppBar.dart';
import 'package:sezapp/model/Patient.dart';

import 'package:sezapp/model/user/User.dart';
import 'package:sezapp/model/user/UserChatContactDTO.dart';

import '../../../constants.dart';

class PatientProfilePage extends StatefulWidget {

  final User activeUser;
  final Patient patient;
  const PatientProfilePage({Key key, this.patient,this.activeUser}) : super(key: key);

  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(title: "Patient Details"),
      ),
      body: Container(
        height: size.height,
        color: kLightColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, 0.05),
                          blurRadius: 50.0,
                          offset: Offset(0, 8))
                    ]),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: buildImage(widget.patient.imageUrl),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name: " + widget.patient.firstName,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Last Name: " + widget.patient.lastName,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Age:" + widget.patient.age,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Sex: " + widget.patient.sex,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                height: 60,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, 0.05),
                        blurRadius: 50.0,
                        offset: Offset(0, 8))
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    sentToChat(widget.patient, widget.activeUser, context);
                    print(widget.activeUser.firstName);
                  },
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Send a message",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    height: 80,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, 0.05),
                            blurRadius: 50.0,
                            offset: Offset(0, 8))
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => AllSeizuresDoctorPage(
                                      patientId: widget.patient.id,
                                    )));
                      },
                      child: ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: kPrimaryLightColor,
                        ),
                        title: Text("All seizures", style: TextStyle(fontSize: 14),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => AllMedicationDoctorPage(
                                    patientId: widget.patient.id,
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                      height: 80,
                      width: size.width * 0.44,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 0.05),
                              blurRadius: 50.0,
                              offset: Offset(0, 8))
                        ],
                      ),
                      child: ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: kPrimaryLightColor,
                        ),
                        title: Text("Medication history", style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, 0.05),
                        blurRadius: 50.0,
                        offset: Offset(0, 8))
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => AddMedicationPage(
                                  userId: widget.patient.id,doctorName: widget.activeUser.firstName,
                              userName: widget.patient.firstName,
                                )));
                  },
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: kPrimaryLightColor,
                    ),
                    title: Text(
                      "Add medication",
                    ),
                  ),
                ),
              ),
              WeekSeizureFrequency(
                weekFreqData: getPatientWeekSezData(widget.patient.id),
                monthFreqData: getPatientMonthSezData(widget.patient.id),
                yearFreqData: getPatientYearSezData(widget.patient.id),
              ),

              PieChartWidget(userId: widget.patient.id,),

              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(checkImagePath(imagePath)),
          height: 118,
          width: 118,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void sentToChat(patient, activeUser, context) {
    UserChatContactDTO senderUser = new UserChatContactDTO();
    senderUser.id = patient.id;
    senderUser.firstName = patient.firstName;
    senderUser.lastName = patient.lastName;
    senderUser.imageUrl = patient.imageUrl;
    senderUser.role = "patient";
    print(activeUser.id);

    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => MessageRoom(
            senderUser: senderUser,
            activeUser: activeUser,
          ),
        ));
  }
}
