import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sos_docteur/constants/style.dart';

class SpecialityCard extends StatelessWidget {
  final String title;
  final String icon;
  final bool isActive;
  final Function onPressed;

  const SpecialityCard(
      {Key key, this.title, this.isActive = false, this.onPressed, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: isActive ? primaryColor.withOpacity(.6) : Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: 50.0,
                  width: 40.0,
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color:
                        isActive ? Colors.white : primaryColor.withOpacity(.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      color: isActive ? primaryColor : Colors.white,
                      height: 20.0,
                      width: 20.0,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "spécialité",
                      style: style1(
                        color: isActive ? Colors.white : primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      title,
                      style: style1(
                          color: isActive ? Colors.white : primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
