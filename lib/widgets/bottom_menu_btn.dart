import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';

class BottomMenuBtn extends StatelessWidget {
  final Widget icon;
  final String label;
  final Function onPressed;
  final bool isActive;

  const BottomMenuBtn({Key key, this.icon, this.label, this.onPressed, this.isActive=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            icon,
            Text(label, style: style1(color: (isActive) ? primaryColor : Colors.grey, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
