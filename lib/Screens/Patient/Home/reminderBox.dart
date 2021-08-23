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
    return Column(children: [
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
      FutureBuilder(
        future: getAllMedicationReminders(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.length==0){
              return Container(


              );
            }else
            return SizedBox(
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 0.1),
                                blurRadius: 20.0,
                                offset: Offset(0, 3))
                          ]),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      margin: EdgeInsets.fromLTRB(25, 10, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            height: 35,
                            decoration: BoxDecoration(
                                color: kListBackColors
                                    .elementAt(index % 10)
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: kListTextColors
                                          .elementAt(index % 10)
                                          .withOpacity(0.1),
                                      spreadRadius: 0.5,
                                      blurRadius: 20.0,
                                      offset: Offset(5, 7))
                                ]),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  FontAwesomeIcons.capsules,
                                  color: kListTextColors.elementAt(index % 10),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "take pills",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: kListTextColors
                                          .elementAt(index % 10)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              snapshot.data[index].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: kPrimaryColor),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              snapshot.data[index].dose, style: TextStyle(fontSize: 14,color: kPrimaryColor),
                              maxLines: 1,
                            ),

                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.clock, color: kPrimaryColor,),
                                SizedBox(
                                 width: 5,
                                ),
                                Text(snapshot.data[index].alarmTime)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          } else
            return Container();
        },
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
