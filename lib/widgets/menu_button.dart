import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        decoration: const BoxDecoration(color: Colors.transparent),
        child: SvgPicture.asset(
          "assets/images/vector/7124099_menu_alt_icon.svg",
          fit: BoxFit.cover,
          color: color ?? Colors.black87,
          height: 30.0,
          width: 30.0,
        ),
      ),
    );
  }
}
