import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../index.dart';

class ACard extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  const ACard({
    Key key,
    this.icon,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.4),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/vector/$icon",
                height: 60.0,
                width: 60.0,
                color: Colors.amber[100],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final Color subColor;
  final Function onPressed;
  const MenuCard({
    Key key,
    this.icon,
    this.title,
    this.color,
    this.subColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(2, 2, 0, 0),
          height: 80.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors
                .primaries[Random().nextInt(Colors.primaries.length)].shade900,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                blurRadius: 12.0,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            "assets/images/vector/$icon",
                            height: 25.0,
                            width: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      CupertinoIcons.square_arrow_right_fill,
                      color: Colors.grey[200],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 0,
          child: Container(
            height: 30,
            width: 30.0,
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(40)),
              gradient: LinearGradient(
                colors: [darkBlueColor, Colors.white],
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/medicine-sign.svg",
                height: 12.0,
                width: 12.0,
                color: Colors.grey[300],
              ),
            ),
          ),
        )
      ],
    );
  }
}

/*Container(
      child: new Material(
        child: new InkWell(
          onTap: (){print("tapped");},
          child: new Container(
            width: 100.0,
            height: 100.0,
          ),
        ),
        color: Colors.transparent,
      ),
      color: Colors.orange,
    ),*/
