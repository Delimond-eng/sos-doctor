// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CostumBtn extends StatelessWidget {
  const CostumBtn({
    Key key,
    this.label,
    this.icon,
    this.color,
    this.onPressed,
    this.radius,
  }) : super(key: key);
  final String label;
  final IconData icon;
  final Color color;
  final Function onPressed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      child: RaisedButton.icon(
        elevation: 10.0,
        color: color ?? Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 5.0),
        ),
        onPressed: onPressed,
        label: Text(
          label.toUpperCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}
