import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constants.dart';
class AddCard extends StatelessWidget {
  final Text text;
  final Icon icon;
  const AddCard({
    this.text,
    this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      margin: EdgeInsets.all(10),
      child: Stack(alignment: Alignment.center, children: [
        Positioned(
          child: Container(

              child: Icon(
                LineAwesomeIcons.plus,
                size: 22,
                color: kPrimaryLightColor,
              ),
          ),
          top: 0,
          right: 0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(
              height: 20,
            ),
            text,
          ],
        ),
      ]),
    );
  }
}