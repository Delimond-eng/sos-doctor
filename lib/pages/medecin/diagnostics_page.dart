import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/models/medecins/medecins_examens_diagnostics_model.dart';

import '../../index.dart';
import 'diagnostic_make_page.dart';
import 'widgets/photo_viewer_widget.dart';

class DiagnosticsPage extends StatefulWidget {
  DiagnosticsPage({Key key}) : super(key: key);

  @override
  _DiagnosticsPageState createState() => _DiagnosticsPageState();
}

class _DiagnosticsPageState extends State<DiagnosticsPage> {
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
                        child: (medecinController.medecinsExamens.isNotEmpty)
                            ? Scrollbar(
                                radius: const Radius.circular(10.0),
                                thickness: 5.0,
                                child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 10.0),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 5.0,
                                  ),
                                  itemCount:
                                      medecinController.medecinsExamens.length,
                                  itemBuilder: (context, index) {
                                    var data = medecinController
                                        .medecinsExamens[index];
                                    return MedDiagnosticCard(
                                      examen: data,
                                      onDiagnostic: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: DiagnosticsMakePage(
                                              examen: data,
                                            ),
                                          ),
                                        );
                                      },
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
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: Text("Aucune diagnostique !"),
                              ),
                      );
                    }),
                  )
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
              "Diagnostiques",
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

class MedDiagnosticCard extends StatelessWidget {
  final Examens examen;
  final Function onDiagnostic;
  final Function onZoomed;
  const MedDiagnosticCard({
    Key key,
    this.examen,
    this.onDiagnostic,
    this.onZoomed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Hero(
              tag: examen.examenId,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(
                    base64Decode(examen.examenDocument),
                  ),
                )),
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
            color: Colors.blue[900],
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.zero,
              child: InkWell(
                onTap: onDiagnostic,
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
                          CupertinoIcons.add_circled_solid,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Diagnostiquer",
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
    );
  }
}
