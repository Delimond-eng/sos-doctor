import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/models/medecins/schedule_model.dart';

class MedScheduleCard extends StatelessWidget {
  final Function onCalling;
  final Function onCancelled;
  final ConsultationsRdv data;

  const MedScheduleCard({this.onCancelled, this.onCalling, this.data});
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Stack(
      // ignore: deprecated_member_use
      overflow: Overflow.visible,
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 15.0),
          elevation: 3.0,
          child: Container(
            height: 150.0,
            width: _size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    width: _size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          darkBlueColor,
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(3.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 12.0,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.calendar,
                                size: 15.0,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                strDateLongFr(data.consultationDate),
                                style: GoogleFonts.lato(
                                  color: Colors.yellow[200],
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              const Icon(
                                Icons.timer,
                                size: 15.0,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "${data.heureDebut} à ${data.heureFin}",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Patient",
                            style: style1(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue[900]),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            truncateString(data.nom, 15, pointed: true),
                            style: style1(
                                fontSize: 18.0, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "Téléphone",
                            style: style1(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue[900]),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            data.telephone,
                            style: style1(
                                fontSize: 15.0, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              gradient: LinearGradient(colors: [
                                Colors.orange[800],
                                Colors.orange[200],
                              ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.3),
                                  blurRadius: 10.0,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: onCalling,
                                borderRadius: BorderRadius.circular(40.0),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.video_camera,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              gradient: LinearGradient(colors: [
                                Colors.grey[900],
                                Colors.grey[300],
                              ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.3),
                                  blurRadius: 10.0,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: onCancelled,
                                borderRadius: BorderRadius.circular(40.0),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.trash,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
