import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sezapp/Screens/Doctor/Home/patientProfile.dart';
import 'package:sezapp/api/doctor_api_service.dart';
import 'package:sezapp/model/Patient.dart';

import '../../../constants.dart';

class ListOfPatientsHome extends StatefulWidget {
  const ListOfPatientsHome({Key key}) : super(key: key);

  @override
  _ListOfPatientsHomeState createState() => _ListOfPatientsHomeState();
}

class _ListOfPatientsHomeState extends State<ListOfPatientsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kLightColor,
      child: FutureBuilder(
        future: getPatients(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  margin:
                      new EdgeInsets.symmetric(horizontal: 24.0, vertical: 7.0),

                  child: Container(
                    height: 90,
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
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PatientProfilePage(patient: snapshot.data[index],)));
                      },
                      child: Ink(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                checkImagePath(snapshot.data[index].imageUrl)),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: kPrimaryLightColor,
                          ),
                          title: Text(
                            snapshot.data[index].firstName +
                                " " +
                                snapshot.data[index].lastName,
                            style: TextStyle(fontSize: 17),
                          ),
                          subtitle: Row(
                            children: [
                              Text("age: " + snapshot.data[index].age),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "• your patient",
                                style:
                                TextStyle(color: Colors.orangeAccent),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<List<Patient>> getPatients() async {
    var data = await apiGetAllPatients();

    List<Patient> patients = [];
    for (var i in data) {
      Patient patient = Patient.fromJson(i);

      patients.add(patient);
    }

    return patients;
  }
}

class PatientProfileCard extends StatelessWidget {
  const PatientProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 180,
      //width: 160,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 0.1),
                blurRadius: 50.0,
                offset: Offset(0, 2))
          ]),
    );
  }
}
