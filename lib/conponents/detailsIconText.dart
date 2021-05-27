import 'package:flutter/material.dart';

import '../constants.dart';
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