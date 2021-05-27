import 'package:flutter/material.dart';
import 'package:sezapp/constants.dart';


class ReminderBox extends StatefulWidget {
  const ReminderBox({Key key}) : super(key: key);

  @override
  _ReminderBoxState createState() => _ReminderBoxState();

}

class _ReminderBoxState extends State<ReminderBox> {


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return
        Container(
          height: 120,
          decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, 0.4),
                    blurRadius: 50.0,
                    offset: Offset(0, 15))
              ]),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          margin: EdgeInsets.fromLTRB(size.width*0.06, 10, size.width*0.06, 10),


          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text("Reminders:",style: TextStyle(color: Colors.white),)
                ],
              )
            ],
          ),
        );


  }
}
