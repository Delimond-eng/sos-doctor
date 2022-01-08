import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sos_docteur/constants/controllers.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/index.dart';
import 'package:sos_docteur/models/patients/home_model.dart';
import 'package:sos_docteur/models/patients/medecin_data_profil_view_model.dart';
import 'package:sos_docteur/pages/medecin/widgets/photo_viewer_widget.dart';
import 'package:sos_docteur/screens/auth_screen.dart';
import 'package:sos_docteur/utilities/utilities.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';

import 'avis_details_page.dart';

class DoctorDetailPage extends StatefulWidget {
  final Profile profil;
  final HomeMedecins supDatas;
  const DoctorDetailPage({Key key, this.profil, this.supDatas})
      : super(key: key);
  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  String selectedDispoId = "";
  String selectedHoure = "";

  List<Heures> heures = [];
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("patient_id").toString(),
      scaffold: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStackHeader(context),
              const SizedBox(
                height: 33.0,
              ),
              Expanded(
                child: Container(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const HeaderTiles(
                            title: "Expériences professionnelles",
                          ),
                          if ((widget.profil.experiences != null) &&
                              (widget.profil.experiences.isNotEmpty)) ...[
                            for (int index = 0;
                                index < widget.profil.experiences.length;
                                index++) ...[
                              ExpCard(
                                data: widget.profil.experiences[index],
                              )
                            ],
                          ],
                          const HeaderTiles(
                            title: "Etudes faites",
                          ),
                          if ((widget.profil.etudesFaites != null) &&
                              (widget.profil.etudesFaites.isNotEmpty)) ...[
                            for (int index = 0;
                                index < widget.profil.etudesFaites.length;
                                index++) ...[
                              ECard(
                                data: widget.profil.etudesFaites[index],
                              )
                            ],
                          ],
                          const HeaderTiles(
                            title: "Autres diplômes",
                          ),
                          if ((widget.supDatas.specialites != null) &&
                              (widget.supDatas.specialites.isNotEmpty)) ...[
                            for (int i = 0;
                                i < widget.supDatas.specialites.length;
                                i++) ...[
                              SpecCard(
                                data: widget.supDatas.specialites[i],
                              )
                            ],
                          ],
                          if ((widget.profil.langues != null) &&
                              (widget.profil.langues.isNotEmpty)) ...[
                            const HeaderTiles(
                              title: "Langues parlées",
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3.5,
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: widget.profil.langues.length,
                              itemBuilder: (context, index) {
                                var data = widget.profil.langues[index];
                                // ignore: avoid_unnecessary_containers
                                return Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10.0,
                                        color: Colors.grey.withOpacity(.3),
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/speech-svgrepo-com.svg",
                                          height: 15.0,
                                          width: 15.0,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          data.langue,
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                          const Divider(
                            height: 30.0,
                            color: Colors.grey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.profil.agenda != null &&
                                  widget.profil.agenda.isNotEmpty) ...[
                                Center(
                                  child: Text(
                                    "Veuillez renseigner les champs ci-dessous pour prendre un rendez-vous avec le Médecin !",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.amber[900],
                                      letterSpacing: 0.50,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.calendar,
                                        color: primaryColor,
                                        size: 15.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        "Sélectionnez le mois",
                                        style: GoogleFonts.lato(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10.0),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < widget.profil.agenda.length;
                                          i++) ...[
                                        DateCard(
                                          isActive:
                                              widget.profil.agenda[i].isActive,
                                          months: strSpliter(strDateLong(
                                              widget.profil.agenda[i].date))[0],
                                          day: strSpliter(strDateLong(
                                              widget.profil.agenda[i].date))[1],
                                          year: strSpliter(strDateLong(
                                              widget.profil.agenda[i].date))[3],
                                          onPressed: () {
                                            setState(() {
                                              heures.clear();
                                              for (var e
                                                  in widget.profil.agenda) {
                                                if (e.isActive == true) {
                                                  e.isActive = false;
                                                }
                                              }
                                              widget.profil.agenda[i].isActive =
                                                  true;
                                              heures.addAll(widget
                                                  .profil.agenda[i].heures);
                                              selectedDispoId = widget
                                                  .profil.agenda[i].agendaId;
                                            });
                                          },
                                        )
                                      ]
                                    ],
                                  ),
                                )
                              ],
                              // ignore: sized_box_for_whitespace
                              const SizedBox(height: 10.0),
                              if ((heures != null) && (heures.isNotEmpty)) ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.time_solid,
                                        color: primaryColor,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        "Les heures de disponibilité",
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                              if ((heures != null) && (heures.isNotEmpty))
                                const SizedBox(height: 20.0),
                              if ((heures != null) && (heures.isNotEmpty)) ...[
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < heures.length;
                                          i++) ...[
                                        TimeCard(
                                          isActive: heures[i].isSelected,
                                          time: heures[i].heure,
                                          onPressed: () {
                                            for (var e in heures) {
                                              if (e.isSelected == true) {
                                                setState(() {
                                                  e.isSelected = false;
                                                });
                                              }
                                            }
                                            setState(() {
                                              heures[i].isSelected = true;
                                              selectedHoure = heures[i].heure;
                                            });
                                          },
                                        )
                                      ]
                                    ],
                                  ),
                                )
                              ],
                              if ((heures != null) && (heures.isNotEmpty)) ...[
                                const SizedBox(height: 20.0),
                              ],
                              if ((widget.profil.agenda != null) &&
                                  (widget.profil.agenda.isEmpty)) ...[
                                Center(
                                  child: Text(
                                    "Médecin indisponible !",
                                    style: GoogleFonts.lato(
                                      fontSize: 18.0,
                                      color: Colors.red[300],
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )
                              ] else ...[
                                Container(
                                  height: 50.0,

                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  width: MediaQuery.of(context).size.width,
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    onPressed: () => reserverRdv(context),
                                    color: primaryColor,
                                    child: Text(
                                      "Prendre un rendez-vous".toUpperCase(),
                                      style: style1(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                )
                              ],
                              Container(
                                height: 50.0,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    image: AssetImage(
                                      "assets/images/shapes/bg5p.png",
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.9),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 35.0,
                                              width: 35.0,
                                              margin: const EdgeInsets.only(
                                                  right: 8.0),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.comment,
                                                  color: primaryColor,
                                                  size: 15.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              "Avis",
                                              style: GoogleFonts.lato(
                                                color: Colors.black87,
                                                fontSize: 18.0,
                                                letterSpacing: 1.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        RaisedButton(
                                          color: Colors.cyan,
                                          child: Text(
                                            "voir plus",
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                child: AvisDetailsPage(
                                                  doctorName:
                                                      widget.supDatas.nom,
                                                  avis: widget.profil.avis,
                                                ),
                                                type: PageTransitionType
                                                    .leftToRightWithFade,
                                              ),
                                            );
                                          },
                                          elevation: 5,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              buildContainerCommentaires()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> reserverRdv(context) async {
    bool isConnected = storage.read("isPatient") ?? false;
    if (isConnected == false) {
      XDialog.showConfirmation(
        context: context,
        icon: Icons.help_rounded,
        title: "Connectez-vous !",
        content:
            "vous devez vous connecter à votre compte pour prendre un rendez-vous avec le Médecin !",
      );
      return;
    }
    if (selectedDispoId.isEmpty) {
      Get.snackbar(
        "Action obligatoire !",
        "vous devez sélectionner une date de disponibilité du médecin!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.amber[900],
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 2,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (selectedHoure.isEmpty) {
      Get.snackbar(
        "Action obligatoire !",
        "vous devez sélectionner une heure de disponibilité du médecin!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.amber[900],
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 2,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      Xloading.showLottieLoading(context);
      var result = await PatientApi.prendreRdvEnLigne(
          dateId: selectedDispoId, heureId: selectedHoure);
      if (result != null) {
        Xloading.dismiss();
        if (result['reponse']['status'] == "success") {
          XDialog.showSuccessAnimation(context);
          setState(() {
            selectedDispoId = "";
            selectedHoure = "";
            heures.clear();
          });
          patientController.refreshDatas();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Widget buildContainerCommentaires() {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
        itemCount: widget.profil.avis.length,
        itemBuilder: (context, index) {
          var data = widget.profil.avis[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: CommentaireCard(
              avis: data,
            ),
          );
        },
      ),
    );
  }

  Widget buildStackHeader(BuildContext context) {
    return Stack(
      // ignore: deprecated_member_use
      overflow: Overflow.visible,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 240.0,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/shapes/bg10.jpg"),
                fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                blurRadius: 12.0,
                color: Colors.grey.withOpacity(.3),
                offset: const Offset(0, 3),
              )
            ],
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
                    offset: const Offset(0, 3))
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.supDatas.photo.isNotEmpty ||
                      widget.supDatas.photo.length > 200)
                    Container(
                      height: 110.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(
                            base64Decode(
                              widget.supDatas.photo,
                            ),
                          ),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                    )
                  else
                    Container(
                      height: 110.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.cyan,
                            Colors.blue[800],
                          ],
                        ),
                        boxShadow: [
                          const BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.black26,
                            offset: Offset(0, 3),
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Dr. ${widget.supDatas.nom}",
                    style: style1(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    widget.supDatas.specialites != null &&
                            widget.supDatas.specialites.isNotEmpty
                        ? widget.supDatas.specialites.length > 1
                            ? widget.supDatas.specialites[0].specialite + ",..."
                            : widget.supDatas.specialites[0].specialite
                        : "aucune spécialité",
                    style: style1(color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 5.0),
                  Center(
                    child: RatingBar.builder(
                      wrapAlignment: WrapAlignment.center,
                      initialRating: widget.supDatas.cote.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemSize: 13.0,
                      allowHalfRating: false,
                      ignoreGestures: true,
                      unratedColor: Colors.transparent,
                      itemCount: 3,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.orange.withOpacity(.7),
                      ),
                      updateOnDrag: false,
                      onRatingUpdate: (double value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          left: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.back,
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
                        child: AuthScreen(),
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
        Positioned(
          bottom: -30.0,
          left: 6.0,
          right: 6.0,
          child: Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                const BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.black12,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.5),
                        shape: BoxShape.circle),
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      "assets/icons/medical-svgrepo-com.svg",
                      height: 20.0,
                      width: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                      "N° d'ordre : ${(widget.profil.numeroOrdre.isNotEmpty) ? widget.profil.numeroOrdre : 'non répertorié'}",
                      style: style1(
                          fontWeight: FontWeight.w700, color: primaryColor))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

//TODO
class SpecCard extends StatelessWidget {
  final HomeSpecialites data;
  const SpecCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, left: 10.0, right: 10.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 10.0),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/medicine-sign.svg",
                  color: Colors.white,
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              data.specialite,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TODO
class SpeechCard extends StatelessWidget {
  final Langues data;
  const SpeechCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, left: 10.0, right: 10.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 10.0),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/speech-svgrepo-com.svg",
                  color: Colors.white,
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              data.langue,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderTiles extends StatelessWidget {
  final String title;
  final IconData icon;
  const HeaderTiles({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          image: AssetImage("assets/images/shapes/bg5p.png"),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: primaryColor.withOpacity(.7)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                height: 35.0,
                width: 35.0,
                margin: const EdgeInsets.only(right: 8.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: icon == null
                      ? SvgPicture.asset(
                          "assets/icons/filter1.svg",
                          color: primaryColor,
                          height: 20.0,
                          width: 20.0,
                          fit: BoxFit.scaleDown,
                        )
                      : Icon(icon, color: Colors.white, size: 15.0),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                title,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO
class ExpCard extends StatelessWidget {
  final Experiences data;
  const ExpCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: const DecorationImage(
          image: AssetImage("assets/images/shapes/bg3.png"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(.7),
          boxShadow: [
            BoxShadow(
              blurRadius: 12.0,
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.5),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        "assets/icons/medical-svgrepo-com.svg",
                        height: 20.0,
                        width: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "A Travailler chez ${data.entite}",
                      style: GoogleFonts.lato(
                        color: primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 15.0, color: Colors.grey),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: BoxDecoration(
                            color: Colors.cyan[900].withOpacity(.5),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: const Icon(CupertinoIcons.flag,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text("Pays"),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      data.adresse.pays,
                      style: GoogleFonts.lato(
                        color: Colors.cyan[800],
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "De ${data.periodeDebut} à ${data.periodeFin}",
                  style: GoogleFonts.lato(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO
class ECard extends StatelessWidget {
  final EtudesFaites data;
  const ECard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 10.0,
      ),
      child: Stack(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage("assets/images/shapes/bg3.png"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white.withOpacity(.7),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12.0,
                    color: Colors.black.withOpacity(.1),
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 25.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(.5),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  "assets/icons/study.svg",
                                  height: 20.0,
                                  width: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              const Text(
                                "Institut ou Université",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            data.institut,
                            style: GoogleFonts.lato(
                              color: primaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 15.0, color: Colors.grey),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 25.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                  color: Colors.cyan[900].withOpacity(.5),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  "assets/icons/study.svg",
                                  height: 20.0,
                                  width: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              const Text("Etude"),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            data.etude,
                            style: GoogleFonts.lato(
                              color: Colors.cyan[800],
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "De ${data.periodeDebut} à ${data.periodeFin}",
                        style: GoogleFonts.lato(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 10.0,
                    offset: const Offset(0, 10.0),
                  )
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: data.certificat != null && data.certificat.length > 200
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoViewer(
                                tag: data.institut,
                                image: data.certificat,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Voir diplôme",
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  final String months;
  final String day;
  final String year;
  final bool isActive;
  final Function onPressed;
  const DateCard({
    Key key,
    this.months,
    this.day,
    this.year,
    this.isActive = false,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 100.0,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        width: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 12.0,
                    offset: const Offset(0, 5),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.4),
                    blurRadius: 12.0,
                    offset: const Offset(0, 3),
                  )
                ],
          gradient: (isActive)
              ? LinearGradient(
                  colors: [
                    Colors.blue[900],
                    Colors.blue,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(
                  colors: [
                    Colors.grey[100],
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                "$months.",
                style: GoogleFonts.lato(
                    color: isActive ? Colors.white : Colors.blue[800],
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10.0),
              Text(
                day,
                style: GoogleFonts.lato(
                    color: isActive ? Colors.white : Colors.black54,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10.0),
              Text(
                year,
                style: GoogleFonts.lato(
                  color: isActive ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentaireCard extends StatelessWidget {
  final Avis avis;
  const CommentaireCard({
    Key key,
    this.avis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.cyan),
          child: Center(
            child: Text(
              avis.patient.substring(0, 1),
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0),
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Flexible(
          child: Container(
            height: 80.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/shapes/bg1.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.grey.withOpacity(.2),
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      avis.avis,
                      style: GoogleFonts.lato(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(strDateLongFr(avis.dateEnregistrement),
                        style: GoogleFonts.lato(color: Colors.blue)),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HeadingTitle extends StatelessWidget {
  final IconData icon;
  final String title, subTitle;
  final Color color;
  const HeadingTitle({this.icon, this.title, this.subTitle, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.0),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.lato(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              subTitle ?? "",
              style: GoogleFonts.lato(
                color: Colors.blue[800],
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  final bool isActive;
  final String time;
  final Function onPressed;

  const TimeCard({Key key, this.isActive, this.time, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.0),
            color: (isActive) ? primaryColor : Colors.white),
        height: 40.0,
        width: 80.0,
        child: Center(
          child: Text(
            time,
            style: style1(
                color: (isActive) ? Colors.white : primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
