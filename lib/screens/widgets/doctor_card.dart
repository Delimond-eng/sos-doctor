// ignore_for_file: deprecated_member_use

import 'dart:convert';

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
    return Stack(
      children: [
        Container(
          height: 110,
          margin: const EdgeInsets.only(bottom: 8.0),
          width: _size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: const DecorationImage(
                image:
                    AssetImage("assets/images/vector/undraw_doctor_kw5l.png"),
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
                      gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.cyan]),
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
                        : Center(
                            child: const Icon(
                              CupertinoIcons.person,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            'Dr. ${truncateString(medecin.nom, 10, pointed: true)}',
                            style: style1(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                fontSize: 16.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          (medecin.specialites != null) &&
                                  (medecin.specialites.isNotEmpty)
                              ? "${medecin.specialites[0].specialite}${medecin.specialites.length > 1 ? ',...' : ''}"
                              : "Aucune spécialité",
                          style: style1(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10.0,
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
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: FlatButton(
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: onPressed,
            child: Icon(
              Icons.arrow_right_alt_rounded,
              color: primaryColor,
            ),
          ),
        )
      ],
      overflow: Overflow.visible,
    );
  }
}
