import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/models/medecins/medecins_examens_diagnostics_model.dart';
import 'package:sos_docteur/widgets/custom_btn_widget.dart';

import '../../index.dart';
import 'widgets/photo_viewer_widget.dart';

class DiagnosticsMakePage extends StatefulWidget {
  const DiagnosticsMakePage({
    Key key,
    this.examen,
  }) : super(key: key);

  final Examens examen;

  @override
  _DiagnosticsMakePageState createState() => _DiagnosticsMakePageState();
}

class _DiagnosticsMakePageState extends State<DiagnosticsMakePage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("medecin_id").toString(),
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
                colors: [
                  Colors.blue[900].withOpacity(.9),
                  Colors.white.withOpacity(.9)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 15.0),
                      child: _header(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Hero(
                          tag: widget.examen.examenId,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                  base64Decode(widget.examen.examenDocument),
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.3),
                                  blurRadius: 15.0,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.zero,
                              child: InkWell(
                                onTap: () {
                                  if (widget.examen.examenDocument.length >
                                      200) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoViewer(
                                          tag: widget.examen.examenId,
                                          image: widget.examen.examenDocument,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                borderRadius: BorderRadius.zero,
                                child: Container(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 16,
                          child: Container(
                            height: 30.0,
                            width: 150.0,
                            decoration: const BoxDecoration(color: Colors.blue),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Examens",
                                  style: GoogleFonts.lato(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1 - 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: StandardInput(
                        controller: controller,
                        hintText: "Entrez votre interpretation diagnostique...",
                        icon: Icons.medical_services_rounded,
                        radius: 0.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomBtn(
                        icon: CupertinoIcons.add,
                        label: "Ajouter diagnostique",
                        color: Colors.green[700],
                        onPressed: () {
                          makeDiagnostic(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makeDiagnostic(context) async {
    if (controller.text.isEmpty) {
      Get.snackbar(
        "Saisie obligatoire!",
        "vous devez entrer votre interpretation de la diagnostique pour effectuer cette opération!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.orange[900],
        maxWidth: MediaQuery.of(context).size.width - 10,
        borderRadius: 0,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      Xloading.showLottieLoading(context);
      var result = await MedecinApi.diagnostiquerExamens(
          diagnostic: controller.text, examenId: widget.examen.examenId);
      if (result != null) {
        Xloading.dismiss();
        controller.text = "";
        XDialog.showSuccessAnimation(context);
      } else {
        Xloading.dismiss();
        Get.snackbar(
          "Echec !",
          "une erreur est survenue lors de l'envoi de données au serveur, veuillez réessayer ultérieurement!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.orange[900],
          maxWidth: MediaQuery.of(context).size.width - 10,
          borderRadius: 0,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (err) {
      print("error from make diagnostic void $err");
    }
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
                    CupertinoIcons.clear,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Interpretation diagnostique",
              style: style1(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}
