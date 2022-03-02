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
        Container(
          height: 150.0,
          width: _size.width,
          margin: const EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/shapes/bg5.png"),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                offset: const Offset(0, 4),
                blurRadius: 12.0,
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    offset: const Offset(0, 4),
                    blurRadius: 12.0,
                  )
                ],
                color: Colors.white.withOpacity(.8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    width: _size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(5.0),
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
                          FlatButton(
                            color: Colors.orange,
                            onPressed: onCalling,
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.video_camera_solid,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          FlatButton(
                            color: Colors.grey,
                            onPressed: onCancelled,
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.trash,
                                color: Colors.white,
                                size: 16.0,
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
