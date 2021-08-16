import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Reports/Seizures/seizure_details.dart';
import 'package:sezapp/conponents/appBar.dart';
import 'package:sezapp/conponents/detailsIconText.dart';
import 'package:sezapp/model/Medication.dart';
import 'package:sezapp/model/Reminder.dart';

import '../../../../constants.dart';

class MedicationDetails extends StatelessWidget {
  final Medication medication;

  MedicationDetails(this.medication);

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAAppBar(title: "Medication Details"),
      ),
      body: Container(
        height: size.height,
        color: kLightColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              DetailsIconText(
                prefix: 'Name: ',
                mainText: medication.name,
                icon: Icon(
                  LineAwesomeIcons.capsules,
                  size: 36,
                  color: kPrimaryColor,
                ),
              ),
              DetailsIconText(
                prefix: "Dose: ",
                mainText: medication.dose,
                icon: Icon(
                  LineAwesomeIcons.pills,
                  size: 36,
                  color: kPrimaryColor,
                ),
              ),
              DetailsIconText(
                prefix: "Start at: ",
                mainText: DateFormat("MMMM, dd, yyyy", languageCode)
                    .format(medication.startDate),
                icon: Icon(
                  LineAwesomeIcons.calendar,
                  size: 36,
                  color: kPrimaryColor,
                ),
              ),
              DetailsIconText(
                prefix: "End at: ",
                mainText: DateFormat("MMMM, dd, yyyy", languageCode)
                    .format(medication.startDate),
                icon: Icon(
                  LineAwesomeIcons.calendar_with_week_focus,
                  size: 36,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                width: 20,
              ),

              DetailsIconText(
                prefix: "How often: ",
                mainText: medication.howOften,

                icon: Icon(
                  LineAwesomeIcons.stopwatch,
                  size: 36,
                  color: kPrimaryColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        LineAwesomeIcons.clock,
                        size: 36,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Reminders: ",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: size.width * 0.46,
                      child: reminderInfo(
                          medication.reminders,
                          Color.fromRGBO(183, 155, 241, 0.6),
                          Color.fromRGBO(107, 103, 158, 0.8)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reminderInfo(
      List<Reminder> reminders, Color backColor, Color textColor) {
    // ignore: deprecated_member_use
    List<Widget> list = [];
    if(reminders.isEmpty){
      list.add(new Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 3),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            "No reminder",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: textColor, fontSize: 15),
          )));
    }else
    for (var i = 0; i < reminders.length; i++) {
      list.add(new Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 3),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            reminders[i].time,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: textColor, fontSize: 15),
          )));
    }

    return new Wrap(children: list);
  }
}
