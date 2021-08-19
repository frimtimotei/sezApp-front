import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sezapp/api/medication_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/MedicationReminder.dart';

class ReminderBox extends StatefulWidget {
  const ReminderBox({Key key}) : super(key: key);

  @override
  _ReminderBoxState createState() => _ReminderBoxState();
}

class _ReminderBoxState extends State<ReminderBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Reminders for today:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
      Container(
        height: 180,
        margin:
            EdgeInsets.fromLTRB(size.width * 0.06, 10, size.width * 0.06, 10),
        child: FutureBuilder(
          future: getAllMedicationReminders(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 160,
                      decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 0.1),
                                blurRadius: 20.0,
                                offset: Offset(0, 3))
                          ]),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:EdgeInsets.fromLTRB(0, 5, 7, 7),
                                    child: Icon(FontAwesomeIcons.bell, color: kRedTextColor,)),
                                Text("You need to ", style: TextStyle(color: Colors.white, fontSize: 14),),


                              ],
                            ),
                            Text("take your pills!", style: TextStyle(color: Colors.white, fontSize: 14),),
                            SizedBox(height: 10,),

                            Row(
                              children: [
                                Expanded(child: Text(snapshot.data[index].name,style: TextStyle(color: Colors.white,fontSize: 17),)),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text("dose: "+snapshot.data[index].dose,style: TextStyle(color: Colors.white,fontSize: 17)),
                            SizedBox(height: 10,),

                            Row(
                              children: [

                                Text("at " +snapshot.data[index].alarmTime, style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600))
                              ],
                            )
                          ],
                        ),

                        ),

                    );
                  });
            } else
              return Container(
                  width: 160,
                  decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, 0.1),
                            blurRadius: 20.0,
                            offset: Offset(0, 3))
                      ]),
                  padding:
                  EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text("Nothing to show."),
              );
          },
        ),
      ),
    ]);
  }

  Future getAllMedicationReminders() async {
    var response = await apiGetAllRemindersMedications();
    List<MedicationReminder> reminders = [];
    for (var u in response) {
      final MedicationReminder medicationReminder =
          MedicationReminder.fromJson(u);
      reminders.add(medicationReminder);
    }
    return reminders;
  }
}
