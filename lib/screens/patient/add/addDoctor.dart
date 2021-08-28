import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/components/customAppBar.dart';
import 'package:sezapp/model/Doctor.dart';

import '../../../constants.dart';

class AddDoctorPage extends StatefulWidget {
  const AddDoctorPage({Key key}) : super(key: key);

  @override
  _AddDoctorPageState createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  String searchString = '';
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(
          title: "Add Doctor",
        ),
      ),
      body: Container(
        color: kLightColor,
        child: Column(
          children: [
            buildSearch(),
            Expanded(
              child: Material(
                  color: Colors.transparent,
                  child: FutureBuilder(
                    future: _getAllDoctorsApi(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index].firstName
                                          .toLowerCase()
                                          .contains(
                                              searchString.toLowerCase()) ||
                                      snapshot.data[index].lastName
                                          .toLowerCase()
                                          .contains(searchString.toLowerCase())
                                  ? Container(
                                      height: 85,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 0.2),
                                                blurRadius: 20.0,
                                                offset: Offset(0, 5))
                                          ]),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 7),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Ink(
                                          child: ListTile(
                                            trailing: OutlinedButton(
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: OutlinedButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor:
                                                    kPrimaryLightColor,
                                              ),
                                              onPressed: () {
                                                CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.confirm,
                                                    confirmBtnColor:
                                                        kPrimaryColor,
                                                    confirmBtnText: "Yes",
                                                    cancelBtnText: "No",
                                                    title:
                                                        "Are you sure you want to add this doctor?",
                                                    text:
                                                        "current doctor will be replaced",
                                                    backgroundColor:
                                                        kPrimaryColor,
                                                    onConfirmBtnTap: () {
                                                      Navigator.pop(context);
                                                      // add a doctor from api
                                                      var res = addDoctor(
                                                          snapshot
                                                              .data[index].id);
                                                      if (res != null) {
                                                        CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .success,
                                                          confirmBtnColor:
                                                              kPrimaryColor,
                                                          title:
                                                              "Doctor Added!",
                                                          text:
                                                              "Your current doctor is: " +
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .firstName,
                                                          backgroundColor:
                                                              kPrimaryColor,
                                                        );
                                                      } else {
                                                        CoolAlert.show(
                                                          context: context,
                                                          type: CoolAlertType
                                                              .error,
                                                          confirmBtnColor:
                                                              kPrimaryColor,
                                                          title: "Error ",
                                                          text:
                                                              "you can't add this doctor!",
                                                          backgroundColor:
                                                              kPrimaryColor,
                                                        );
                                                      }
                                                    });
                                              },
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  checkImagePath(snapshot
                                                      .data[index].imageUrl)),
                                            ),
                                            title: Text(snapshot
                                                    .data[index].firstName +
                                                " " +
                                                snapshot.data[index].lastName),
                                            subtitle: Row(
                                              children: [
                                                Text("age: " +
                                                    snapshot.data[index].age),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    child: Text(
                                                  "• available",
                                                  style: TextStyle(
                                                      color: kGreenTextColor),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container();
                            });
                      } else
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      height: 46,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 0.1),
                blurRadius: 20.0,
                offset: Offset(0, 10)),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 4),
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

  _getAllDoctorsApi() async {
    var response = await apiGetAllDoctors();
    List<Doctor> doctors = [];
    for (var u in response) {
      final Doctor doctor = Doctor.fromJson(u);
      doctors.add(doctor);
    }

    return doctors;
  }

  Future addDoctor(userId) async {
    var response = await apiAddDoctors(userId);

    if (response['id'] != null) {
      return true;
    } else
      return null;
  }
}
