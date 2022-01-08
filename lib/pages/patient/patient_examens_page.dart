import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sos_docteur/constants/globals.dart';
import 'package:sos_docteur/models/patients/patient_diagnostics_model.dart';
import 'package:sos_docteur/pages/medecin/widgets/photo_viewer_widget.dart';
import 'package:sos_docteur/screens/auth_screen.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';

import '../../index.dart';

class PatientExamenPage extends StatefulWidget {
  const PatientExamenPage({Key key}) : super(key: key);

  @override
  _PatientExamenPageState createState() => _PatientExamenPageState();
}

class _PatientExamenPageState extends State<PatientExamenPage> {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("patient_id").toString(),
      scaffold: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/vector/undraw_medicine_b1ol.png"),
                fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[900], Colors.white],
                stops: const [0.1, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 15.0),
                    child: _header(),
                  ),
                  Expanded(
                    child: Obx(() {
                      return Container(
                        child: (patientController.diagnostics.isNotEmpty)
                            ? Scrollbar(
                                radius: const Radius.circular(10.0),
                                thickness: 5.0,
                                child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 10.0),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.80,
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                  ),
                                  itemCount:
                                      patientController.diagnostics.length,
                                  itemBuilder: (context, index) {
                                    var data =
                                        patientController.diagnostics[index];
                                    return DiagnosticCard(
                                      diagnostic: data,
                                      onZoomed: () {
                                        if (data.examenDocument.length > 200) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PhotoViewer(
                                                tag: data.examenId,
                                                image: data.examenDocument,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      onShowDiagnostic: () {
                                        if (data.diagnostiques.isEmpty) {
                                          Get.snackbar(
                                            "Aucune diagnostique",
                                            "La diagnostique pour cette ordonnance n'est pas encore prêt !",
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.blue,
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                4,
                                            borderRadius: 2,
                                            duration:
                                                const Duration(seconds: 3),
                                          );
                                          return;
                                        }
                                        showDiagnostics(context,
                                            diagnostics: data.diagnostiques);
                                      },
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: Text("Aucun examen"),
                              ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          elevation: 10.0,
          icon: const Icon(CupertinoIcons.cloud_download, color: Colors.white),
          label: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.cyan,
            enabled: true,
            child: Text(
              "Charger examens",
              style: GoogleFonts.lato(color: Colors.white),
            ),
          ),
          onPressed: showUploadingFile,
        ),
      ),
    );
  }

  Widget topBtn(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/vector/undraw_doctor_kw5l.png"),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber[900].withOpacity(.8),
          borderRadius: BorderRadius.zero,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.zero,
          child: InkWell(
            borderRadius: BorderRadius.zero,
            onTap: showUploadingFile,
            child: Container(
              height: 80.0,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: const Icon(
                      CupertinoIcons.cloud_upload,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Charger une ordonnance",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
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
              "Mes examens",
              style: style1(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            )
          ],
        ),
        if (storage.read("isPatient") == true)
          UserSession()
        else
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRightWithFade,
                  alignment: Alignment.topCenter,
                  child: AuthScreen(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.person_circle_fill,
                    color: primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Se connecter",
                    style: style1(
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }

  void showDiagnostics(context, {List<Diagnostiques> diagnostics}) {
    showScrollableSheet(
      context,
      childrens: <Widget>[
        Text(
          "Diagnostiques",
          style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        const SizedBox(
          height: 20.0,
        ),
        for (int i = 0; i < diagnostics.length; i++)
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            margin: const EdgeInsets.only(bottom: 15.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.grey.withOpacity(.2),
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 15,
                  color: Colors.green[700],
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  diagnostics[i].diagnostique,
                  style: GoogleFonts.lato(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          )
      ],
    );
  }

  void showUploadingFile() {
    var isPatient = storage.read("isPatient") ?? false;

    if (isPatient) {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        elevation: 2,
        barrierColor: Colors.black26,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 150.0,
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TileBtn(
                    icon: CupertinoIcons.photo,
                    label: "Charger via gallerie",
                    onPressed: () async {
                      var pickedFile =
                          await takePhoto(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        var bytes = File(pickedFile.path).readAsBytesSync();
                        String strDoc = base64Encode(bytes);
                        Xloading.showLottieLoading(context);
                        var res = await PatientApi.uploadExamens(file: strDoc);
                        if (res != null) {
                          Xloading.dismiss();
                          if (res['reponse']['status'] == "success") {
                            Get.back();
                            XDialog.showSuccessAnimation(context);
                            patientController.refreshDiagnostics();
                          } else {
                            Get.snackbar(
                              "Echec!",
                              "le chargement du fichier a echoué, veuillez réessayer ultérieurement!",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.white,
                              backgroundColor: Colors.amber[900],
                              maxWidth: MediaQuery.of(context).size.width - 4,
                              borderRadius: 2,
                              duration: const Duration(seconds: 3),
                            );
                            Get.back();
                          }
                        }
                      }
                      //print(avatar);
                    },
                  ),
                ),
                const SizedBox(width: 20.0),
                Flexible(
                  child: TileBtn(
                    onPressed: () async {
                      var pickedFile =
                          await takePhoto(source: ImageSource.camera);
                      if (pickedFile != null) {
                        var bytes = File(pickedFile.path).readAsBytesSync();
                        String strDoc = base64Encode(bytes);

                        Xloading.showLottieLoading(context);

                        var res = await PatientApi.uploadExamens(file: strDoc);

                        if (res != null) {
                          Xloading.dismiss();
                          if (res['reponse']['status'] == "success") {
                            Get.back();
                            XDialog.showSuccessAnimation(context);
                            patientController.refreshDiagnostics();
                          } else {
                            Get.snackbar(
                              "Echec!",
                              "le chargement du fichier ordonnance a echoué!",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.white,
                              backgroundColor: Colors.amber[900],
                              maxWidth: MediaQuery.of(context).size.width - 4,
                              borderRadius: 2,
                              duration: const Duration(seconds: 3),
                            );
                            Get.back();
                          }
                        }
                      }
                    },
                    icon: CupertinoIcons.photo_camera,
                    label: "Prendre une capture",
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      XDialog.show(
        context: context,
        icon: Icons.info_rounded,
        content:
            "vous devez vous connectez à votre compte pour effectuer cette opération",
        title: "Connectez-vous!",
        onValidate: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRightWithFade,
              alignment: Alignment.topCenter,
              child: AuthScreen(),
            ),
          );
        },
      );
    }
  }

  Future<PickedFile> takePhoto({ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source);

    if (pickedFile != null) {
      return pickedFile;
    } else {
      return null;
    }
  }
}

class DiagnosticCard extends StatelessWidget {
  final ExamensPatient diagnostic;
  final Function onShowDiagnostic;
  final Function onZoomed;
  const DiagnosticCard({
    Key key,
    this.diagnostic,
    this.onShowDiagnostic,
    this.onZoomed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.9),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Hero(
                  tag: diagnostic.examenId,
                  child: Container(
                    decoration: BoxDecoration(
                      image: (diagnostic.examenDocument.length > 200)
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                base64Decode(diagnostic.examenDocument),
                              ),
                            )
                          : const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/vector/undraw_doctor_kw5l.png"),
                            ),
                    ),
                    child: Center(
                      child: Container(
                        color: Colors.blue[900].withOpacity(.6),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.zero,
                          child: InkWell(
                            onTap: onZoomed,
                            borderRadius: BorderRadius.zero,
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              child: Icon(
                                CupertinoIcons.eye_solid,
                                size: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: (diagnostic.diagnostiques.isEmpty)
                    ? Colors.blue[900]
                    : Colors.green[700],
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.zero,
                  child: InkWell(
                    onTap: onShowDiagnostic,
                    borderRadius: BorderRadius.zero,
                    child: Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: const Icon(
                              CupertinoIcons
                                  .line_horizontal_3_decrease_circle_fill,
                              size: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "voir diagnostiques",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
