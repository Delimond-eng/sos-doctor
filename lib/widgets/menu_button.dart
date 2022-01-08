import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sos_docteur/constants/style.dart';

class MenuButton extends StatelessWidget {
  final Color color;
  final Function onPressed;

  const MenuButton({Key key, this.color, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 3),
          )
        ], color: Colors.blue[50], shape: BoxShape.circle),
        child: SvgPicture.asset(
            "assets/images/vector/7124099_menu_alt_icon.svg",
            fit: BoxFit.cover,
            color: color ?? primaryColor,
            height: 30.0,
            width: 30.0),
      ),
    );
  }
}
