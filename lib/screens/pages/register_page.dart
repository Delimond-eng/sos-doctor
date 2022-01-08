import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sos_docteur/models/patients/account_model.dart';
import 'package:sos_docteur/widgets/custom_checkbox_widget.dart';
import 'package:sos_docteur/widgets/custom_dropdown.dart';

import '../../index.dart';

class RegisterPage extends StatefulWidget {
  final Function onBackToLogin;

  const RegisterPage({Key key, this.onBackToLogin}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String gender;
  String typeUser;

  final textNom = TextEditingController();
  final textEmail = TextEditingController();
  final textPhone = TextEditingController();
  final textPass = TextEditingController();
  final textConfirmation = TextEditingController();
  String countryCode = "";
  bool allowed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: AuthInputText(
            icon: CupertinoIcons.person,
            hintText: "Entez votre nom complet",
            inputController: textNom,
            isPassWord: false,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: AuthInputText(
            icon: CupertinoIcons.envelope_badge,
            hintText: "Entez votre adresse email",
            inputController: textEmail,
            keyType: TextInputType.emailAddress,
            isPassWord: false,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                blurRadius: 12.0,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: IntlPhoneField(
            controller: textPhone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintMaxLines: 9,
              contentPadding: EdgeInsets.only(top: 10, bottom: 10),
              hintText: "n° de téléphone",
              hintStyle: TextStyle(color: Colors.black54, fontSize: 14.0),
              border: InputBorder.none,
              counterText: '',
            ),
            initialCountryCode: 'CD',
            onChanged: (phone) {
              setState(() {
                countryCode = phone.countryCode;
              });
            },
            onCountryChanged: (phone) {
              setState(() {
                countryCode = phone.countryCode;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CustomDropdown(
                  items: const ["Masculin", "Féminin"],
                  hintText: " Sexe...",
                  selectedValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                  child: CustomDropdown(
                hintText: " Vous êtes ?",
                items: const ["Médecin", "Patient"],
                selectedValue: typeUser,
                onChanged: (value) {
                  setState(() {
                    typeUser = value;
                  });
                },
              ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: AuthInputText(
            icon: CupertinoIcons.lock,
            hintText: "Entez le mot de passe",
            inputController: textPass,
            isPassWord: true,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: AuthInputText(
            icon: CupertinoIcons.checkmark_alt_circle_fill,
            hintText: "Confirmez votre mot de passe",
            inputController: textConfirmation,
            isPassWord: true,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: CostumChexkBox(
            hasColored: false,
            title: "J'acceptes les politiques de confidentialité !",
            value: allowed,
            onChanged: () {
              setState(() {
                allowed = !allowed;
              });
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: (allowed) ? registerMedecin : null,
            color: primaryColor,
            child: Text(
              "Créer".toUpperCase(),
              style: style1(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        )
      ],
    );
  }

  Future<void> registerMedecin() async {
    if (textNom.text.isEmpty) {
      Get.snackbar(
        " Saisie obligatoire !",
        "vous devez entrer votre nom complet!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
        duration: const Duration(seconds: 5),
      );
      return;
    }
    if (textEmail.text.isEmpty) {
      Get.snackbar(
        " Saisie obligatoire !",
        "vous devez entrer votre adresse email!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (textPhone.text.isEmpty) {
      Get.snackbar(
        " Saisie obligatoire !",
        "vous devez entrer votre téléphone!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (textPass.text.isEmpty) {
      Get.snackbar(
        " Saisie obligatoire !",
        "vous devez entrer votre mot de passe de sécurité!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (gender.isEmpty) {
      Get.snackbar(
        " Saisie obligatoire !",
        "vous devez sélectionner votre sexe !",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (textPass.text != textConfirmation.text) {
      Get.snackbar(
        "Echec de la confirmation de mot de passe!",
        "La confirmation de votre mot de passe a echoué !",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
      );
      return;
    }

    if (textPass.text.length < 8) {
      Get.snackbar(
        "Mot de passe trop court !",
        "Le mot passe doit avoir au moins 8 caratères !",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[50],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (hasPasswordValidated(textPass.text) == false) {
      Get.snackbar(
        "Mot de passe trop faible!",
        "Veuillez vous assurer que le mot de passe entré commence par une lettre majuscule suivi des lettres minuscules, des chiffres et des caractères spéciaux !",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 8),
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 10,
      );
      return;
    }
    Medecins medecin = Medecins(
      nom: textNom.text,
      email: textEmail.text,
      telephone: '$countryCode${textPhone.text}',
      password: textPass.text,
      gender: gender,
    );

    Patient patient = Patient(
      patientPass: textPass.text,
      patientEmail: textEmail.text,
      patientNom: textNom.text,
      patientPhone: '$countryCode${textPhone.text}',
      patientSexe: gender,
    );

    var result;
    if (allowed) {
      if (typeUser == "Patient") {
        Xloading.showLottieLoading(context);
        result = await PatientApi.registerAccount(patient: patient);
      } else if (typeUser == "Médecin") {
        Xloading.showLottieLoading(context);
        result = await MedecinApi.registerAccount(medecin: medecin);
      } else {
        XDialog.showErrorMessage(
          context,
          color: Colors.amber[900],
          title: "Action obligatoire!",
          message:
              "vous devez sélectionner le type d'utilisateur que vous êtes!",
        );
        return;
      }
    } else {
      Get.snackbar(
        "Action obligatoire !",
        "vous devez accepter nos conditions & politiques de confidentialité !",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 8,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (result == null) {
      Xloading.dismiss();
      Get.snackbar(
        "Echec !",
        "la création du compte n'a pas été effectuée!,\nemail ou numéro de téléphone est déjà utilisé pour un autre $typeUser!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red[100],
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 8,
        duration: const Duration(seconds: 5),
      );
      return;
    } else {
      Xloading.dismiss();
      Get.snackbar(
        "Félicitation !",
        "votre compte $typeUser a été créé avec succès!\nveuillez utiliser vos identifiants pour vous connecter !",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 5),
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 8,
      );
      Future.delayed(const Duration(seconds: 3));
      widget.onBackToLogin();
    }
  }
}
