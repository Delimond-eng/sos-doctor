// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/models/patients/home_model.dart';

class MedCard extends StatelessWidget {
  final Function onPressed;
  final HomeMedecins medecin;

  const MedCard({Key key, this.onPressed, this.medecin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Container(
      height: 110,
      margin: const EdgeInsets.only(bottom: 8.0),
      width: _size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: const DecorationImage(
            image: AssetImage("assets/images/vector/undraw_doctor_kw5l.png"),
            fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white.withOpacity(.9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient:
                          LinearGradient(colors: [darkBlueColor, Colors.cyan]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 12.0,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: medecin.photo.length > 200
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                alignment: Alignment.topCenter,
                                image: MemoryImage(
                                  base64Decode(medecin.photo),
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.3),
                                  blurRadius: 12.0,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                          )
                        : const Center(
                            child: Icon(
                              CupertinoIcons.person_solid,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Dr. ${medecin.nom}',
                                  style: style1(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  (medecin.specialites != null) &&
                                          (medecin.specialites.isNotEmpty)
                                      ? "${medecin.specialites[Random().nextInt(medecin.specialites.length)].specialite}${medecin.specialites.length > 1 ? ',...' : ''}"
                                      : "Aucune spécialité",
                                  style: style1(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                initialRating: (medecin.cote != null)
                                    ? medecin.cote.toDouble()
                                    : 1.0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemSize: 13.0,
                                allowHalfRating: false,
                                ignoreGestures: true,
                                unratedColor: Colors.transparent,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.orange.withOpacity(.7),
                                ),
                                updateOnDrag: false,
                                onRatingUpdate: (double value) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
