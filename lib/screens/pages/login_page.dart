import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/models/patients/account_model.dart';
import 'package:sos_docteur/widgets/custom_checkbox_widget.dart';

import '../../index.dart';
import '../home_screen.dart';
import '../home_screen_for_medecin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController identifiant = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isMedecin = false;
  bool isPatient = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: AuthInputText(
            icon: CupertinoIcons.person_circle_fill,
            hintText: "Entez votre email ou n° de téléphone",
            inputController: identifiant,
            keyType: TextInputType.emailAddress,
            isPassWord: false,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: AuthInputText(
            icon: CupertinoIcons.lock,
            inputController: password,
            hintText: "Entez le mot de passe",
            isPassWord: true,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Vous êtes ?",
            style: GoogleFonts.lato(
              color: Colors.blue[800],
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: [
              Flexible(
                child: CostumChexkBox(
                  title: "Patient",
                  value: isPatient,
                  hasColored: true,
                  onChanged: () {
                    setState(() {
                      isPatient = true;
                      isMedecin = false;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Flexible(
                child: CostumChexkBox(
                  title: "Médecin",
                  value: isMedecin,
                  hasColored: true,
                  onChanged: () {
                    setState(() {
                      isPatient = false;
                      isMedecin = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: () async {
              if (isPatient == false && isMedecin == false) {
                Get.snackbar(
                  "Obligatoire !",
                  "vous devez cocher la une case d'utilisation !",
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.red[200],
                  backgroundColor: Colors.black87,
                  maxWidth: MediaQuery.of(context).size.width - 4,
                  borderRadius: 10,
                  duration: const Duration(seconds: 2),
                );
                return;
              }
              if (identifiant.text.isEmpty) {
                Get.snackbar(
                  "Saisie obligatoire !",
                  "vous devez entrer votre identifiant pour vous connecter!",
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.red[200],
                  backgroundColor: Colors.black87,
                  maxWidth: MediaQuery.of(context).size.width - 4,
                  borderRadius: 10,
                );
                return;
              }
              if (password.text.isEmpty) {
                Get.snackbar(
                  "Saisie obligatoire !",
                  "vous devez entrer votre mot de passe pour vous connecter!",
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.red[200],
                  backgroundColor: Colors.black87,
                  maxWidth: MediaQuery.of(context).size.width - 4,
                  borderRadius: 10,
                );
                return;
              }
              Medecins medecin = Medecins(
                identifiant: identifiant.text,
                password: password.text,
              );
              Patient patient = Patient(
                patientIdentifiant: identifiant.text,
                patientPass: password.text,
              );
              Xloading.showLottieLoading(context);
              if (isMedecin) {
                var result = await MedecinApi.login(medecin: medecin);
                if (result == null) {
                  Xloading.dismiss();
                  Get.snackbar(
                    "Identifiants erronés !",
                    "vos identifiants de connexion sont erronés !",
                    snackPosition: SnackPosition.TOP,
                    colorText: Colors.red[200],
                    backgroundColor: Colors.black87,
                    maxWidth: MediaQuery.of(context).size.width - 4,
                    borderRadius: 10,
                    duration: const Duration(seconds: 2),
                  );
                  return;
                } else {
                  await medecinController.refreshDatas();
                  Xloading.dismiss();
                  await Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        child: MedecinHomeScreen(),
                      ),
                      (Route<dynamic> route) => false);

                  return;
                }
              } else if (isPatient) {
                var result = await PatientApi.login(patient: patient);

                if (result == null) {
                  Xloading.dismiss();
                  Get.snackbar(
                    "Identifiants erronés !",
                    "vos identifiants de connexion sont erronés !",
                    snackPosition: SnackPosition.TOP,
                    colorText: Colors.red[200],
                    backgroundColor: Colors.black87,
                    maxWidth: MediaQuery.of(context).size.width - 4,
                    borderRadius: 10,
                    duration: const Duration(seconds: 2),
                  );
                  return;
                } else {
                  await patientController.refreshDatas();
                  Xloading.dismiss();
                  await Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: HomeScreen(),
                      ),
                      (Route<dynamic> route) => false);

                  return;
                }
              }
            },
            color: Colors.green,
            child: Text(
              "Connecter".toUpperCase(),
              style: style1(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Center(
          child: TextButton(
            child: Text(
              "Mot de passe oublié ?",
              style: style1(
                  color: primaryColor,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () {
              print("on press");
            },
          ),
        )
      ],
    );
  }
}
