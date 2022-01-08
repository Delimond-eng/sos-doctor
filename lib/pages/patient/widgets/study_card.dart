import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_docteur/constants/style.dart';

class StudyCard extends StatelessWidget {
  final String institut;
  final String certificat;
  final String etude;
  final String periodeDebut;
  final String periodeFin;
  final String pays;
  final Function onViewed;
  const StudyCard({
    Key key,
    this.institut,
    this.certificat,
    this.etude,
    this.pays,
    this.periodeDebut,
    this.periodeFin,
    this.onViewed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: .5),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 5),
          )
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: primaryColor.withOpacity(.5),
            ),
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/study.svg",
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  etude.toUpperCase(),
                  style: GoogleFonts.lato(
                      color: primaryColor, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text("Année d'Etudes"),
              const SizedBox(height: 5.0),
              Flexible(
                child: Text(
                  "$periodeDebut à $periodeFin ${pays != null && pays.isNotEmpty ? ' en ' + pays : ''}",
                  style: GoogleFonts.lato(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "voir diplôme",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: onViewed,
                ),
              )
              /*if (certificat.length > 200 && certificat != null)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(
                        base64Decode(certificat),
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        blurRadius: 12.0,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                )
              else
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        blurRadius: 12.0,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                )*/
            ],
          ),
        ],
      ),
    );
  }
}
