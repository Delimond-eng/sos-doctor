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
                    padding: const EdgeInsets.all(8.0),
                    width: _size.width,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.5),
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
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
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
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Icon(
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
                                  fontWeight: FontWeight.w700,
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
                      Container(
                        height: 40.0,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          onPressed: onCalling,
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.video_camera_solid,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: -5,
          child: GestureDetector(
            onTap: onCancelled,
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red[200],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.4),
                      blurRadius: 12.0,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.minus,
                  color: Colors.red[800],
                  size: 18.0,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
