// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/models/patients/consult_rdv_model.dart';

class ClientScheduleCard extends StatelessWidget {
  final ConsultationsRdv data;
  final Function onPressed;
  final Function onCancelled;

  const ClientScheduleCard({this.data, this.onPressed, this.onCancelled});
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 160.0,
          width: _size.width,
          margin: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/shapes/bg3.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white.withOpacity(.8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                          color: primaryColor,
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
                        width: 8.0,
                      ),
                      const Text(
                        "Médecin",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Dr. ${truncateString(data.medecin.nom, 20, pointed: true)}",
                    style: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(height: 1, width: 200, color: Colors.grey),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.calendar,
                            size: 15.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            strDateLong(data.date),
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.time_solid,
                            size: 15.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "${data.heureDebut} -  ${data.heureFin}",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.cyan[800],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: (data.medecin.photo.length > 200 && data.medecin.photo != null)
              ? Container(
                  height: 80.0,
                  width: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(
                        base64Decode(data.medecin.photo),
                      ),
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 12.0,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                )
              : Container(
                  height: 80.0,
                  width: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue[800],
                        Colors.cyan,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.4),
                        blurRadius: 12.0,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
        Positioned(
          bottom: 25.0,
          right: 8.0,
          height: 30.0,
          child: Row(
            children: [
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.grey[800],
                child: Text(
                  "Annuler",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: onCancelled,
                elevation: 5,
              ),
              const SizedBox(
                width: 5.0,
              ),
              RaisedButton(
                color: Colors.cyan,
                child: Text(
                  "Détail",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: onPressed,
                elevation: 5,
              ),
            ],
          ),
        )
      ],
    );
  }
}
