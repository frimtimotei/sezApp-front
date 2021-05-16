import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:sezapp/conponents/appBar.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/Seizure.dart';

class SeizureDetails extends StatelessWidget {
  final Seizure seizure;

  SeizureDetails(this.seizure);

  @override
  Widget build(BuildContext context) {

    String languageCode = Localizations.localeOf(context).languageCode;
    format(Duration d) => d.toString().split('.').first.padLeft(8, "0");


    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAAppBar(title: "Seizure Details"),
        ),
        body: Container(
          height: size.height,
          color: kLightColor,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                DetailsIconText(
                  prefix: 'Date: ',
                  mainText: DateFormat("MMMM, dd, yyyy", languageCode)
                      .format(seizure.date),
                  icon: Icon(
                    LineAwesomeIcons.calendar,
                    size: 36,
                    color: kPrimaryColor,
                  ),
                ),
                DetailsIconText(
                  mainText: seizure.startAt.format(context),
                  prefix: "Start at: ",
                  icon: Icon(
                    LineAwesomeIcons.clock,
                    size: 36,
                    color: kPrimaryColor,
                  ),
                ),
                DetailsIconText(
                  mainText: format(seizure.duration),
                  prefix: "Duration: ",
                  icon: Icon(
                    LineAwesomeIcons.stopwatch,
                    size: 36,
                    color: kPrimaryColor,
                  ),
                ),


            /////////////////////////////////////////////////////////////////
                /// Trigger
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
                        Icons.flag_outlined,
                        size: 36,
                        color: kPrimaryColor,
                      ),),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Trigger: ",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: size.width*0.57,
                    child: chipFromList(seizure.sezTrigger.split(","),Color.fromRGBO(
                        255, 167, 167, 0.6), Color.fromRGBO(
                        224, 109, 109, 0.8)),


                    ),

                ],
              ),
            ),

             ///////////////////////////////////////////////////////
             /// Seizure Type
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
                          LineAwesomeIcons.brain,
                          size: 36,
                          color: kPrimaryColor,
                        ),),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Type: ",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: size.width*0.57,
                        child: chipFromList(seizure.type.split(","),Color.fromRGBO(
                            162, 219, 184, 0.6), Color.fromRGBO(
                            100, 172, 141, 0.8)),


                      ),

                    ],
                  ),
                ),


                /////////////////////////////////////////////////////
                //Activity

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
                          LineAwesomeIcons.walking,
                          size: 36,
                          color: kPrimaryColor,
                        ),),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Activity: ",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: size.width*0.57,
                        child: chipFromList(seizure.activity.split(","),Color.fromRGBO(
                            174, 203, 255, 0.6), Color.fromRGBO(
                            105, 141, 208, 0.8)),


                      ),

                    ],
                  ),
                ),


              //////////////////////////////////////
                ///Mood
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
                          LineAwesomeIcons.hushed_face,
                          size: 36,
                          color: kPrimaryColor,
                        ),),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Mood: ",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: size.width*0.57,

                        child: outlineChipFromList(seizure.mood.split(","),Color.fromRGBO(
                            183, 155, 241, 0.6), Color.fromRGBO(
                            107, 103, 158, 0.8)),


                      ),

                    ],
                  ),
                ),


                /////////////////////////////////////////////////////////////
                ///Location
                DetailsIconText(
                  mainText: seizure.location,
                  prefix: "Location: ",
                  icon: Icon(
                    LineAwesomeIcons.map_marker,
                    size: 36,
                    color: kPrimaryColor,
                  ),
                ),


                ////Note
                DetailsIconText(
                  mainText: seizure.notes,
                  prefix: "Notes: ",
                  icon: Icon(
                    LineAwesomeIcons.alternate_pencil,
                    size: 36,
                    color: kPrimaryColor,
                  ),
                ),

                SizedBox(height: 30,),


              ],
            ),
          ),
        ),
    );
  }



  Widget chipFromList(List<String> strings, Color backColor, Color textColor){

    List<Widget> list = new List<Widget>();
    for(var i = 0; i < strings.length; i++){
      list.add(new Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 3),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            strings[i],
            style: TextStyle(
                fontWeight: FontWeight.w500, color: textColor, fontSize: 15),
          )));
    }
    return new Wrap(children: list);
  }
}

Widget outlineChipFromList(List<String> strings, Color backColor, Color textColor){

  List<Widget> list = new List<Widget>();
  for(var i = 0; i < strings.length; i++){
    list.add(new Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 3),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: backColor, width: 2),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          strings[i],
          style: TextStyle(
              fontWeight: FontWeight.w500, color: textColor, fontSize: 15),
        )));
  }
  return new Wrap(children: list);
}


class DetailsIconText extends StatelessWidget {
  final String prefix;
  final String mainText;
  final Icon icon;

  const DetailsIconText(
      {Key key,
      @required this.mainText,
      @required this.prefix,
      @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: icon),
          SizedBox(
            width: 20,
          ),
          Text(
            prefix,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            mainText,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: kPrimaryColor),
          ),
        ],
      ),
    );
  }




}
