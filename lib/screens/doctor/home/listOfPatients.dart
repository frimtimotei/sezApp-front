import 'package:flutter/material.dart';
import 'package:sezapp/api/doctorApiService.dart';
import 'package:sezapp/model/Patient.dart';
import 'package:sezapp/model/user/User.dart';
import 'package:sezapp/screens/doctor/home/patientProfile.dart';

import '../../../constants.dart';

class ListOfPatientsHome extends StatefulWidget {
  const ListOfPatientsHome({Key key}) : super(key: key);

  @override
  _ListOfPatientsHomeState createState() => _ListOfPatientsHomeState();
}

class _ListOfPatientsHomeState extends State<ListOfPatientsHome> {
  String searchString = '';
  final searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final User activeUser = ModalRoute.of(context).settings.arguments;
    return Container(
      color: kLightColor,
      child: Column(
        children: [
          buildSearch(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Your patients",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPatients(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return noPatientsWidget();
                  } else
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index].firstName
                                    .toLowerCase()
                                    .contains(searchString.toLowerCase()) ||
                                snapshot.data[index].lastName
                                    .toLowerCase()
                                    .contains(searchString.toLowerCase())
                            ? Card(
                                color: Colors.transparent,
                                elevation: 0,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 7.0),
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    borderRadius: BorderRadius.circular(13),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 0.05),
                                          blurRadius: 50.0,
                                          offset: Offset(0, 8))
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  PatientProfilePage(
                                                    activeUser: activeUser,
                                                    patient:
                                                        snapshot.data[index],
                                                  )));
                                    },
                                    child: Ink(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              checkImagePath(snapshot
                                                  .data[index].imageUrl)),
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
                                            Text("age: " +
                                                snapshot.data[index].age),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "• your patient",
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      },
                    );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget noPatientsWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
            child: Text(
          "No patients added, wait until one patient add you as a personal doctor.",
          style: TextStyle(fontStyle: FontStyle.italic),
        )),
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      height: 47,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 0.1),
                blurRadius: 20.0,
                offset: Offset(0, 10)),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchString = value;
          });
        },
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
          ),
          focusColor: kPrimaryLightColor,
          suffixIcon: searchString.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: kPrimaryColor,
                  ),
                  onTap: () {
                    searchController.clear();
                    setState(() {
                      searchString = '';
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          border: InputBorder.none,
        ),
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
