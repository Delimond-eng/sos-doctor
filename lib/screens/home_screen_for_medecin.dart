import 'dart:convert';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/index.dart';
import 'package:sos_docteur/pages/medecin/diagnostics_page.dart';
import 'package:sos_docteur/pages/medecin/medecin_agenda_config.dart';
import 'package:sos_docteur/pages/medecin/medecin_agenda_view_page.dart';
import 'package:sos_docteur/pages/medecin/medecin_profil_page.dart';
import 'package:sos_docteur/pages/medecin/medecin_profil_view_page.dart';
import 'package:sos_docteur/pages/medecin/medecin_schuddle_page.dart';
import 'package:sos_docteur/screens/auth_screen.dart';
import 'package:sos_docteur/video_calls/pages/pickup_layout.dart';

import 'package:sos_docteur/widgets/menu_item_widget.dart';

import 'widgets/custom_header_widget7.dart';
import 'widgets/menu_card.dart';

class MedecinHomeScreen extends StatefulWidget {
  const MedecinHomeScreen({Key key}) : super(key: key);

  @override
  _MedecinHomeScreenState createState() => _MedecinHomeScreenState();
}

class _MedecinHomeScreenState extends State<MedecinHomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  String uid = storage.read("medecin_id").toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: uid,
      scaffold: Scaffold(
        key: _globalKey,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/shapes/bg4p.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.white60, Colors.white54],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, left: 10.0, right: 10, bottom: 10.0),
                    child: Header2(
                      onOpenMenu: () {
                        _globalKey.currentState.openDrawer();
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 20.0),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .2,
                              margin: const EdgeInsets.only(
                                  bottom: 20.0, top: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/vector/undraw_medicine_b1ol.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.4),
                                    blurRadius: 12.0,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.4),
                                      blurRadius: 12.0,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue[900].withOpacity(.8),
                                      Colors.cyan.withOpacity(.8)
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              "Bienvenue Dr. ${storage.read('medecin_nom')} sur ",
                                          style: GoogleFonts.lato(
                                            fontSize: 17.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            shadows: [
                                              const Shadow(
                                                color: Colors.black26,
                                                blurRadius: 10.0,
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'SOS',
                                              style: GoogleFonts.lato(
                                                letterSpacing: 1.20,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.cyan[100],
                                              ),
                                            ),
                                            const TextSpan(text: "  "),
                                            TextSpan(
                                              text: 'Docteur',
                                              style: GoogleFonts.lato(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.cyan[100],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "La plateforme numérique qui vous permet de rester en contact permenant avec vos patients !",
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    MenuCard(
                                      color: Colors.blue[900],
                                      subColor: Colors.blue[50],
                                      icon: "schedule-calendar-svgrepo-com.svg",
                                      title: "Mes rendez-vous",
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            alignment: Alignment.topCenter,
                                            curve: Curves.easeIn,
                                            child: MedecinScheddulePage(),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    MenuCard(
                                      color: Colors.cyan[600],
                                      subColor: Colors.cyan[50],
                                      icon: "profile-user-svgrepo-com.svg",
                                      title: "Mon profile",
                                      onPressed: () async {
                                        var medecinId =
                                            storage.read("medecin_id");
                                        if (medecinId != null) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .leftToRightWithFade,
                                              child: MedecinProfilViewPage(),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    MenuCard(
                                      color: Colors.deepPurple,
                                      icon: "schedule-svgrepo-com2.svg",
                                      title: "Config. agenda",
                                      subColor: Colors.deepPurple[50],
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: MedecinAgendaConfigPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    MenuCard(
                                      color: Colors.indigo[900],
                                      subColor: Colors.indigo[100],
                                      icon: "schedule-svgrepo-com.svg",
                                      title: "Mon agenda",
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: MedecinAgendaPageView(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    MenuCard(
                                      color: Colors.green[700],
                                      icon: "user-cog-svgrepo-com.svg",
                                      title: "Config. profile",
                                      subColor: Colors.green[50],
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            alignment: Alignment.topCenter,
                                            curve: Curves.easeIn,
                                            child: MedecinProfilPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    MenuCard(
                                      color: Colors.amber[900],
                                      icon: "ordonnance.svg",
                                      title: "Diagnostiques & interpretations",
                                      subColor: Colors.amber[50],
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: DiagnosticsPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          elevation: 0,
          child: SideMenu(),
        ),
        /*bottomSheet: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomMenuBtn(
              icon: Icon(
                CupertinoIcons.house_fill,
                size: 15.0,
                color: primaryColor,
              ),
              label: "Acceuil",
              isActive: true,
              onPressed: () {
                var pickedTime = getShowTimePicker(context);
                String formatedTime = pickedTime.format(context);
                print(formatedTime);
              },
            ),
            BottomMenuBtn(
              icon: Badge(
                badgeContent: Text("0", style: style1(color: Colors.white)),
                position: const BadgePosition(top: -12, end: -10),
                child: const Icon(CupertinoIcons.chat_bubble_text_fill,
                    size: 15.0, color: Colors.grey),
              ),
              label: "Messages",
            ),
            BottomMenuBtn(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const MedecinProfilViewPage(),
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.person_fill,
                  size: 18.0, color: Colors.grey),
              label: "Profil",
            ),
          ],
        ),
      )*/
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final String name = storage.read("medecin_nom") ?? "";
  final String email = storage.read("medecin_email") ?? "";
  final String avatar = storage.read("photo") ?? "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/shapes/bg10.jpg"),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(.8)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (avatar.length > 200)
                Container(
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: MemoryImage(base64Decode(avatar)),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.4),
                        blurRadius: 12.0,
                        offset: const Offset(0, 4),
                      )
                    ],
                    shape: BoxShape.circle,
                  ),
                )
              else
                Container(
                  height: 100.0,
                  width: 100.0,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.cyan, primaryColor]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            blurRadius: 12.0,
                            offset: const Offset(0, 3))
                      ],
                      shape: BoxShape.circle),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Text("Dr. $name" ?? "",
                  style: style1(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 5.0),
              Text(email ?? "",
                  style: style1(
                      color: Colors.cyan[100],
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 20.0),
              Divider(
                color: Colors.cyan.withOpacity(.4),
                thickness: 0.5,
                indent: 50.0,
                endIndent: 50.0,
              ),
              const SizedBox(height: 30.0),
              MenuItem(
                icon:
                    const Icon(CupertinoIcons.person_fill, color: Colors.cyan),
                label: 'Configuration profile',
                onPressed: () {
                  Get.back();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      curve: Curves.easeIn,
                      child: const MedecinProfilPage(),
                    ),
                  );
                },
              ),
              MenuItem(
                icon: const Icon(CupertinoIcons.person_circle_fill,
                    color: Colors.cyan),
                label: 'Mon profile',
                onPressed: () async {
                  Get.back();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: const MedecinProfilViewPage(),
                    ),
                  );
                },
              ),
              MenuItem(
                icon: const Icon(CupertinoIcons.calendar_badge_plus,
                    color: Colors.cyan),
                label: 'Configuration agenda',
                onPressed: () {
                  Get.back();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: const MedecinAgendaConfigPage(),
                    ),
                  );
                },
              ),
              MenuItem(
                icon: const Icon(Icons.task_alt_outlined, color: Colors.cyan),
                label: 'Mes rendez-vous',
                onPressed: () {
                  Get.back();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      curve: Curves.easeIn,
                      child: const MedecinScheddulePage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Divider(
                color: Colors.cyan.withOpacity(.4),
                thickness: 0.5,
                indent: 50.0,
                endIndent: 50.0,
              ),

              /*MenuItem(
                icon: const Icon(CupertinoIcons.info, color: Colors.cyan),
                label: 'Aide',
                onPressed: () {},
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(
                      "assets/images/vector/undraw_medicine_b1ol.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                primaryColor.withOpacity(.8),
                Colors.deepOrangeAccent.withOpacity(.8)
              ]),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        Positioned(
          left: 115.0,
          right: 5.0,
          top: 20.0,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "Trouvez les meilleurs spécialistes de santé sur SOs Docteur",
              style: style1(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                  letterSpacing: 2.0),
            ),
          ),
        ),
        Positioned(
          top: -50.0,
          left: 10.0,
          child: Image.asset(
            "assets/images/vector/chat.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}

class TileCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onPressed;
  final bool isActive;

  const TileCard(
      {Key key, this.label, this.icon, this.onPressed, this.isActive = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 8.0, left: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: (isActive) ? primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 12.0,
                  offset: const Offset(0, 3))
            ]),
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                color: (isActive) ? Colors.white : primaryColor, size: 20.0),
            const SizedBox(width: 5.0),
            Text(label,
                style: style1(
                    color: (isActive) ? Colors.white : primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0))
          ],
        ),
      ),
    );
  }
}
