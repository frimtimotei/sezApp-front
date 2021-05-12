

import 'package:flutter/material.dart';

class InputFiled extends StatelessWidget {
  final String hintText;
  final bool obscuredText;
  final TextEditingController controller;
  final Function validator;

  const InputFiled({
    this.hintText,

    this.obscuredText,
    this.controller,
    this.validator,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 0.2),
                blurRadius: 20.0,
                offset: Offset(0, 15))
          ]),
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
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
