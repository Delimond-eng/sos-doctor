
import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';
class MenuItem extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Widget icon;
  final Widget trIcon;

  const MenuItem({Key key, this.onPressed, this.label, this.icon, this.trIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(label, style: style1(color: Colors.white),),
      onTap: onPressed,
      trailing: trIcon,
    );
  }
}