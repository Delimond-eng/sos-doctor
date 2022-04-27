import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Widget icon;
  final Widget trIcon;

  const MenuItem({Key key, this.onPressed, this.label, this.icon, this.trIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        label,
        style: GoogleFonts.lato(color: Colors.grey[100]),
      ),
      onTap: onPressed,
      trailing: trIcon,
    );
  }
}
