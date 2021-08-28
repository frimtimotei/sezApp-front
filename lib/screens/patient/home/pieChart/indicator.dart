import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    @required this.color,
    @required this.text,

    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      Size size=MediaQuery.of(context).size;
       return Container(

         decoration: BoxDecoration(
             color: color,
             borderRadius: BorderRadius.circular(20),
             boxShadow: [
               BoxShadow(
                   color: Color.fromRGBO(143, 148, 251, 0.4),
                   blurRadius: 2.0,
                   offset: Offset(0, 1))
             ]),
         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
       margin: EdgeInsets.symmetric(vertical: 2,horizontal: 2),



       child: Text(text,style: TextStyle(fontSize: 16,color: textColor),),);
  }
}
