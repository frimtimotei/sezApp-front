import 'package:flutter/material.dart';
class WhiteIconButton extends StatelessWidget {
  const WhiteIconButton(
      {Key key,
        @required this.height,
        @required this.width,
        @required this.icon,
        @required this.text,
        @required this.callback})
      : super(key: key);

  final double height;
  final double width;
  final Icon icon;
  final Text text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        color: Colors.white,
        onPressed: callback,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        padding: EdgeInsets.all(0.0),
        elevation: 0,
        child: Stack(
          children: [
            Positioned(
              child: Container(

                child: icon,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 30),
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}