import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/screens/auth_screen.dart';

import '../index.dart';

class UserSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.blue[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.person_circle_fill,
              color: Colors.green,
              size: 18.0,
            ),
            const SizedBox(
              width: 8.0,
            ),
            if (storage.read("isPatient") == true) ...[
              Obx(() {
                return Text(
                  truncateString(
                      patientController.user.value.profile.nom.capitalizeFirst,
                      8),
                  style: style1(
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                  ),
                );
              })
            ] else if (storage.read("isMedecin") == true) ...[
              Text(
                "Dr. ${truncateString(storage.read("medecin_nom").toString().capitalizeFirst, 6)}",
                style: style1(
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              )
            ],
            const SizedBox(
              width: 4.0,
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black45, size: 15.0)
          ],
        ),
      ),
      onSelected: (value) {
        switch (value) {
          case 1:
            XDialog.show(
              icon: Icons.help_rounded,
              context: context,
              content:
                  "Etes-vous sûr de vouloir vous déconnecter de votre compte ?",
              title: "Déconnexion",
              onValidate: () {
                storage.remove("patient_id");
                storage.remove("patient_name");
                storage.remove("patient_email");
                storage.remove("isPatient");
                storage.remove("medecin_id");
                storage.remove("medecin_nom");
                storage.remove("medecin_email");
                storage.remove("isMedecin");

                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: AuthScreen(),
                        type: PageTransitionType.bottomToTop),
                    (route) => false);
                return;
              },
            );
            break;
          case 2:
            XDialog.show(
              icon: Icons.help_rounded,
              context: context,
              content: "Etes-vous sûr de vouloir fermer l'application ?",
              title: "Fermeture",
              onValidate: () {
                exit(0);
              },
            );
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                child: Icon(
                  Icons.exit_to_app,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                'Déconnexion',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 15.0),
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.red,
                ),
              ),
              Text(
                "Fermer",
                style: GoogleFonts.mulish(color: Colors.white, fontSize: 15.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}
