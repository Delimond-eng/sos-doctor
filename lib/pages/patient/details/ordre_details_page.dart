import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/index.dart';
import 'package:sos_docteur/models/patients/medecin_data_profil_view_model.dart';
import 'package:sos_docteur/pages/medecin/widgets/photo_viewer_widget.dart';
import 'package:sos_docteur/screens/auth_screen.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';

class OrdreDetailsPage extends StatelessWidget {
  final List<OrdreMedecin> medecinOrdres;
  const OrdreDetailsPage({Key key, this.medecinOrdres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: _header(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(7.0, 10.0, 7.0, 0),
                child: Column(
                  children: medecinOrdres
                      .map(
                        (e) => OrdreCard(
                          data: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/shapes/bg10.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withOpacity(.5), Colors.deepOrange],
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.grey.withOpacity(.3),
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (storage.read("isPatient") == true)
                    UserSession()
                  else
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRightWithFade,
                            alignment: Alignment.topCenter,
                            child: const AuthScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.person_circle_fill,
                              color: primaryColor,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Se connecter",
                              style: style1(
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -25.0,
          left: 10.0,
          right: 10.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  darkBlueColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.grey.withOpacity(.3),
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Center(
              child: Text(
                "Ordres de médecin",
                style: GoogleFonts.lato(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        )
      ],
      clipBehavior: Clip.none,
    );
  }
}

class OrdreCard extends StatelessWidget {
  final OrdreMedecin data;
  const OrdreCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Pays : ",
                          style: GoogleFonts.lato(
                            color: Colors.grey[200],
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: truncateString(
                                data.pays,
                                30,
                                pointed: true,
                              ),
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      RichText(
                        text: TextSpan(
                          text: "N° d'ordre : ",
                          style: GoogleFonts.lato(
                            color: Colors.grey[200],
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: data.numeroOrdre,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(5),
                  ),
                ),
                child: data.document != null && data.document.length > 500
                    ? Hero(
                        tag: data.numeroOrdre,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(5.0)),
                            image: DecorationImage(
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                base64Decode(data.document),
                              ),
                            ),
                          ),
                          child: Material(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(5.0)),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(5.0),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoViewer(
                                            image: data.document,
                                            tag: data.numeroOrdre,
                                          )),
                                );
                              },
                              child: Container(),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.panorama_outlined,
                          color: Colors.pink,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
