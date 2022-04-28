import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';

class StandardBtn extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final String label;
  final double radius;

  const StandardBtn(
      {Key key, this.onPressed, this.color, this.label, this.radius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: onPressed,
        color: color ?? primaryColor,
        child: Text(
          label.toUpperCase(),
          style: style1(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 30.0),
        ),
      ),
    );
  }
}
