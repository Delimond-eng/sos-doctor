import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/widgets/editable_field_widget.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';

import '../../index.dart';

class PatientProfilPage extends StatefulWidget {
  @override
  _PatientProfilPageState createState() => _PatientProfilPageState();
}

class _PatientProfilPageState extends State<PatientProfilPage> {
  final TextEditingController textNom = TextEditingController();
  final TextEditingController textEmail = TextEditingController();
  final TextEditingController textTelephone = TextEditingController();
  final TextEditingController textOldPass = TextEditingController();
  final TextEditingController textConfirm = TextEditingController();
  final TextEditingController textPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    setState(() {
      textNom.text = patientController.user.value.profile.nom;
      textEmail.text = patientController.user.value.profile.email;
      textTelephone.text = patientController.user.value.profile.telephone;
      textOldPass.text = patientController.user.value.profile.pass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("patient_id").toString(),
      scaffold: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/shapes/bg5p.png"),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(.5),
                  Colors.white.withOpacity(.7),
                  Colors.white.withOpacity(.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Obx(
              () {
                return SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: _header(),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: Container(
                          child: _profils(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Mon Profile",
              style: style1(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0),
            )
          ],
        ),
        UserSession()
      ],
    );
  }

  Widget _profils() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      primaryColor,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 12.0,
                      offset: const Offset(0, 10),
                    )
                  ],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: (patientController.user.value.profile.nom != null)
                      ? Text(
                          patientController.user.value.profile.nom
                              .substring(0, 1)
                              .toUpperCase(),
                          style: GoogleFonts.lato(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          CupertinoIcons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                ),
              ),
              const SizedBox(height: 20.0),
              EditableField(
                title: "Nom",
                controller: textNom,
                onEdit: () async {
                  if (textNom.text !=
                      patientController.user.value.profile.nom) {
                    await updateProfile(context,
                        key: "nom", value: textNom.text);
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              EditableField(
                title: "Email",
                controller: textEmail,
                onEdit: () async {
                  if (textEmail.text !=
                      patientController.user.value.profile.email) {
                    await updateProfile(context,
                        key: "email", value: textEmail.text);
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              EditableField(
                title: "Téléphone",
                controller: textTelephone,
                onEdit: () async {
                  if (textTelephone.text !=
                      patientController.user.value.profile.telephone) {
                    await updateProfile(context,
                        key: "telephone", value: textTelephone.text);
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ExpandableNotifier(
                child: ScrollOnExpand(
                  child: Column(
                    children: <Widget>[
                      ExpandablePanel(
                        theme: const ExpandableThemeData(
                          fadeCurve: Curves.bounceIn,
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToExpand: true,
                          tapBodyToCollapse: true,
                          hasIcon: false,
                        ),
                        header: Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            border: Border(
                              bottom: BorderSide(
                                color: primaryColor,
                                width: .5,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.4),
                                blurRadius: 12.0,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mot de passe",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                    fontSize: 16.0,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.2),
                                        blurRadius: 10.0,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: ExpandableIcon(
                                      theme: const ExpandableThemeData(
                                        expandIcon: CupertinoIcons.pencil,
                                        collapseIcon: CupertinoIcons.clear,
                                        iconColor: Colors.white,
                                        iconSize: 20.0,
                                        hasIcon: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: primaryColor,
                                width: .5,
                              ),
                            ),
                          ),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Ancien mot de passe"),
                                const SizedBox(
                                  height: 8,
                                ),
                                AuthInputText(
                                  icon: CupertinoIcons.lock_fill,
                                  hintText: "Ancien mot de passe",
                                  inputController: textOldPass,
                                  isPassWord: true,
                                  hasReadOnly: true,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text("Confirmation Ancien mot de passe"),
                                const SizedBox(
                                  height: 8,
                                ),
                                AuthInputText(
                                  icon: CupertinoIcons.lock,
                                  hintText: "Entrez votre ancien mot de passe",
                                  inputController: textConfirm,
                                  isPassWord: true,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text("Nouveau mot de passe"),
                                const SizedBox(
                                  height: 8,
                                ),
                                AuthInputText(
                                  icon: CupertinoIcons.lock,
                                  hintText: "Entrez le nouveau mot de passe",
                                  inputController: textPass,
                                  isPassWord: true,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.blue,
                                    child: Text(
                                      "Modifier",
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (textConfirm.text.isEmpty) {
                                        Get.snackbar(
                                          "Saisie obligatoire !",
                                          "Vous devez confirmer votre ancien mot de passe !",
                                          snackPosition: SnackPosition.TOP,
                                          colorText: Colors.red[50],
                                          backgroundColor: Colors.black87,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              4,
                                          borderRadius: 10,
                                          duration: const Duration(seconds: 5),
                                        );
                                        return;
                                      }
                                      if (textConfirm.text !=
                                          textOldPass.text) {
                                        Get.snackbar(
                                          "Erreur !",
                                          "Mot de passe de confirmation différent !",
                                          snackPosition: SnackPosition.TOP,
                                          colorText: Colors.red[50],
                                          backgroundColor: Colors.black87,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              4,
                                          borderRadius: 10,
                                          duration: const Duration(seconds: 5),
                                        );
                                        return;
                                      }
                                      if (textPass.text.isEmpty) {
                                        Get.snackbar(
                                          "Saisie obligatoire !",
                                          "Vous devez entrer le nouveau mot de passe !",
                                          snackPosition: SnackPosition.TOP,
                                          colorText: Colors.red[50],
                                          backgroundColor: Colors.black87,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              4,
                                          borderRadius: 10,
                                          duration: const Duration(seconds: 5),
                                        );
                                        return;
                                      }

                                      if (textPass.text.length < 8) {
                                        Get.snackbar(
                                          "Mot de passe trop court !",
                                          "Le mot passe doit avoir au moins 8 caratères !",
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: Colors.red[50],
                                          backgroundColor: Colors.black87,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              4,
                                          borderRadius: 10,
                                          duration: const Duration(seconds: 5),
                                        );
                                        return;
                                      }

                                      if (hasPasswordValidated(textPass.text) ==
                                          false) {
                                        Get.snackbar(
                                          "Mot de passe trop faible!",
                                          "Veuillez vous assurer que le mot de passe entré commence par une lettre majuscule suivi des lettres minuscules, des chiffres et des caractères spéciaux !",
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: const Duration(seconds: 8),
                                          colorText: Colors.red[50],
                                          backgroundColor: Colors.black87,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              4,
                                          borderRadius: 10,
                                        );
                                        return;
                                      }
                                      if (textPass.text != textOldPass.text) {
                                        await updateProfile(context,
                                            key: "pass", value: textPass.text);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> updateProfile(context, {String key, String value}) async {
    XDialog.show(
      content: "Etes-vous sûr de vouloir modifier cette donnée ?",
      context: context,
      icon: Icons.help,
      title: "Modification !",
      onValidate: () async {
        Xloading.showLottieLoading(context);
        await PatientApi.editProfil(
          key: key,
          value: value,
        ).then((res) async {
          Xloading.dismiss();
          if (res != null) {
            print(res);
            XDialog.showSuccessAnimation(context);
            await patientController.refreshProfile();
            await initData();
          }
        });
      },
    );
  }
}
