import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Add/addDoctor.dart';
import 'package:sezapp/Screens/Patient/Add/addMedication.dart';
import 'package:sezapp/Screens/Patient/Add/addSeizure.dart';
import 'package:sezapp/conponents/addCard.dart';
import 'package:sezapp/constants.dart';

class PatientAddPage extends StatefulWidget {
  @override
  _PatientAddPageState createState() => _PatientAddPageState();
}

class _PatientAddPageState extends State<PatientAddPage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightColor,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Add new Entry",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor,
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(

                child: OpenContainer(

                  closedElevation: 1,
                  tappable: true,
                  closedColor: Colors.white,

                  transitionDuration: Duration(milliseconds: 350),

                  closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  transitionType: ContainerTransitionType.fade,
                  openBuilder: (BuildContext context, VoidCallback _) {
                    return AddSeizurePage();

                  },

                  closedBuilder:
                      (BuildContext context, VoidCallback openContainer) {
                    return Container(
                      child: AddCard(
                        icon: Icon(
                          LineAwesomeIcons.brain,
                          size: 50,
                          color: kPrimaryLightColor,
                        ),
                        text: Text(
                          "Add Seizure",
                          style: TextStyle(fontSize: 16, color: kPrimaryColor),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: OpenContainer(
                  closedElevation: 1,
                  tappable: true,
                  closedColor: Colors.white,
                  transitionDuration: Duration(milliseconds: 350),
                  closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  openBuilder: (BuildContext context, VoidCallback _) {

                    return AddMedicationPage();
                  },
                  closedBuilder:
                      (BuildContext context, VoidCallback openContainer) {
                    return AddCard(
                      icon:Icon(
                        LineAwesomeIcons.capsules,
                        size: 50,
                        color: kPrimaryLightColor,
                      ),

                      text: Text(
                        "Add Medication",
                        style: TextStyle(fontSize: 16, color: kPrimaryColor),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 50,
              ),
              Container(
                child: OpenContainer(
                  closedElevation: 1,
                  tappable: true,
                  closedColor: Colors.white,
                  transitionDuration: Duration(milliseconds: 350),
                  closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  openBuilder: (BuildContext context, VoidCallback _) {

                    return AddDoctorPage();
                  },
                  closedBuilder:
                      (BuildContext context, VoidCallback openContainer) {
                    return AddCard(
                      icon:Icon(
                        LineAwesomeIcons.medical_clinic,
                        size: 50,
                        color: kPrimaryLightColor,
                      ),

                      text: Text(
                        "Add Doctor",
                        style: TextStyle(fontSize: 16, color: kPrimaryColor),
                      ),
                    );
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }


}
