import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Doctor/Reports/allMedication.dart';
import 'package:sezapp/Screens/Doctor/Reports/allSeizures.dart';
import 'package:sezapp/Screens/Doctor/Reports/seizuresAction.dart';
import 'package:sezapp/Screens/Patient/Profile/profile_widget.dart';
import 'package:sezapp/Screens/Patient/Reports/chart_seizures.dart';
import 'package:sezapp/conponents/appBar.dart';
import 'package:sezapp/model/Patient.dart';

import '../../../constants.dart';

class PatientProfilePage extends StatelessWidget {
  final Patient patient;

  const PatientProfilePage({Key key, @required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAAppBar(title: "Patient Details"),
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
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                        child: buildImage(patient.imageUrl),
                    ),
                    SizedBox(width: 30,),
                    Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget> [
                        Text("Name: "+ patient.firstName, style: TextStyle(fontSize: 17),),
                        SizedBox(height: 5,),
                        Text("Last Name:" + patient.lastName,style: TextStyle(fontSize: 17)),
                        SizedBox(height: 5,),
                        Text("Age:" + patient.age,style: TextStyle(fontSize: 17)),
                        SizedBox(height: 5,),
                        Text("Sex: "+ patient.sex,style: TextStyle(fontSize: 17))
                      ],
                    )
                  ],
                ),
              ),

              Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                 Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(20,0, 0, 10),
                      height: 80,
                      width: size.width*0.4,
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
                      child:  InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => AllSeizuresDoctorPage(patientId: patient.id,)));
                        },
                        splashColor: kPrimaryLightColor,
                        hoverColor: kPrimaryLightColor,
                        focusColor: kPrimaryLightColor,

                        child: ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: kPrimaryLightColor,
                          ),
                          title: Text("All seizures"),
                        ),
                      ),

                    ),



                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => AllMedicationDoctorPage(patientId: patient.id,)));

                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 10),

                      height: 80,
                      width: size.width*0.43,
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
                        title: Text("Medication history "),
                      ),


                    ),
                  ),
                ],
              ),

              WeekSeizureFrequency(weekFreqData: getPatientWeekSezData(patient.id),monthFreqData: getPatientMonthSezData(patient.id),yearFreqData: getPatientYearSezData(patient.id),),
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
}
