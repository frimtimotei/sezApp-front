import 'package:flutter/material.dart';

class ButtonFull extends StatelessWidget {
  final String name;
  final VoidCallback callback;
  final double width;
  final double height;

  const ButtonFull({
    @required this.name,
    @required this.callback,
    @required this.width,
    @required this.height,
    Key key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: callback,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(143, 148, 251, 1.0),
                  Color.fromRGBO(143, 148, 251, 0.6)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '$name',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}