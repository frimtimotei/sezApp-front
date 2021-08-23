

import 'package:flutter/material.dart';

class CustomInputFiled extends StatelessWidget {
  final String hintText;
  final bool obscuredText;
  final TextEditingController controller;
  final Function validator;

  const CustomInputFiled({
    @required this.hintText,

    @required this.obscuredText,
    @required this.controller,
    @required this.validator,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.4, horizontal: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 0.1),
                blurRadius: 20.0,
                offset: Offset(0, 10))
          ]),
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '$hintText',
                hintStyle: TextStyle(color: Colors.grey[400])),
            validator: validator,
            controller: controller,
            obscureText: obscuredText,
          ),
        ),
      ]),
    );
  }
}
