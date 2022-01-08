import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/utilities/utilities.dart';
import 'package:sos_docteur/widgets/menu_button.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';

class Header1 extends StatelessWidget {
  final Function onOpenMenu;
  final Function onLoggedIn;
  const Header1({Key key, this.onOpenMenu, this.onLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuButton(onPressed: onOpenMenu),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SOS Docteur",
                    style: style1(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Shimmer.fromColors(
                    enabled: true,
                    baseColor: Colors.red,
                    highlightColor: Colors.white,
                    child: Text(
                      "24h/24, 7j/7",
                      style: style1(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (storage.read("isPatient") == false ||
              storage.read("isPatient") == null)
            GestureDetector(
              onTap: onLoggedIn,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      primaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.4),
                      blurRadius: 12.0,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.person_circle_fill,
                      color: Colors.white,
                      size: 18.0,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Se connecter",
                      style: style1(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          if (storage.read("isPatient") == true) UserSession()
        ],
      ),
    );
  }
}

class Header2 extends StatelessWidget {
  final Function onOpenMenu;
  const Header2({Key key, this.onOpenMenu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              MenuButton(onPressed: onOpenMenu),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                "SOS Docteur",
                style: style1(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0),
              ),
            ],
          ),
        ),
        if (storage.read("isMedecin") == true) UserSession()
      ],
    );
  }
}
