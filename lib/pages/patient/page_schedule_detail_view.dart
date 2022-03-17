import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sos_docteur/models/patients/consult_rdv_model.dart';
import 'package:sos_docteur/screens/auth_screen.dart';
import 'package:sos_docteur/video_calls/models/call_model.dart';
import 'package:sos_docteur/video_calls/pages/call_screen.dart';
import 'package:sos_docteur/video_calls/permissions.dart';
import 'package:sos_docteur/video_calls/resources/call_methods.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';
import 'dart:math' as math;

import '../../index.dart';

class PageScheduleDetailView extends StatefulWidget {
  final ConsultationsRdv data;
  const PageScheduleDetailView({Key key, this.data}) : super(key: key);

  @override
  _PageScheduleDetailViewState createState() => _PageScheduleDetailViewState();
}

class _PageScheduleDetailViewState extends State<PageScheduleDetailView> {
  bool hasCommentViewed = false;
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection('call');
  final TextEditingController _avisController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("patient_id").toString(),
      scaffold: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/shapes/bg5p.png"),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(.8),
                  Colors.white.withOpacity(.7),
                  Colors.white.withOpacity(.7),
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
                      horizontal: 16.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
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
                            width: 8.0,
                          ),
                          Text(
                            "Rendez-vous détails",
                            style: style1(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
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
                                child: const AuthScreen(),
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
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.cyan, primaryColor],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 12.0,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: widget.data.medecin.photo.isEmpty
                                  ? const Center(
                                      child: Icon(
                                        CupertinoIcons.person_fill,
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: MemoryImage(base64Decode(
                                              widget.data.medecin.photo)),
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 12.0,
                                            offset: Offset(0, 3),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Dr. ${widget.data.medecin.nom}",
                              style: GoogleFonts.lato(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                  color: primaryColor,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(.1),
                                      offset: const Offset(0, 1),
                                      blurRadius: 10.0,
                                    )
                                  ]),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Dr. ${widget.data.medecin.email}",
                              style: GoogleFonts.lato(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Colors.orange[800],
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Votre rendez-vous est programmé de ${widget.data.heureDebut} à ${widget.data.heureFin} du ${strDateLongFr(widget.data.date).capitalize}, veuillez contacter le Médecin dans cette intervalle du temps, en dehors de cette intervalle le Médecin ne sera pas disponible !",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CostumIconBtn(
                                  icon: CupertinoIcons.captions_bubble_fill,
                                  color: Colors.green[700],
                                  onPressed: () {
                                    setState(() {
                                      hasCommentViewed = !hasCommentViewed;
                                    });
                                  },
                                ),

                                /*CostumIconBtn(
                                  icon: CupertinoIcons.video_camera_solid,
                                  color: Colors.blue[800],
                                  onPressed: () {
                                    onJoin();
                                  },
                                ),*/
                                const SizedBox(
                                  width: 10.0,
                                ),
                                CostumIconBtn(
                                  onPressed: () async {
                                    await XDialog.showCotation(
                                      context,
                                      consultrdvId:
                                          widget.data.consultationRdvId,
                                    );
                                    /*callCollection
                                      .where('caller_id',
                                          isEqualTo: storage.read("patient_id"))
                                      .snapshots()
                                      .listen((QuerySnapshot querySnapshot) {
                                    querySnapshot.docs.forEach((document) => print(
                                        "query: ${document.get('receiver_name')}"));
                                  });*/

                                    //Call call = Call(callerId: "1");

                                    /*try {
                                      callCollection
                                          .where('caller_id', isEqualTo: "1")
                                          .snapshots()
                                          .listen(
                                              (QuerySnapshot querySnapshot) {
                                        querySnapshot.docs
                                            .forEach((document) async {
                                          print(document.reference);
                                          await FirebaseFirestore.instance
                                              .runTransaction((txn) async =>
                                                  await txn.delete(
                                                      document.reference));
                                        });
                                      });
                                    } catch (err) {
                                      print("error from $err");
                                    }*/
                                  },
                                  icon: CupertinoIcons.hand_thumbsup_fill,
                                  color: Colors.amber[900],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (hasCommentViewed)
                  Container(
                    height: 70.0,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.3),
                                    blurRadius: 12.0,
                                    offset: const Offset(0, 3))
                              ],
                            ),
                            child: TextField(
                              controller: _avisController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontSize: 14.0),
                              decoration: InputDecoration(
                                hintText: "Entrez votre avis...",
                                contentPadding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    CupertinoIcons.pencil,
                                    size: 20.0,
                                    color: primaryColor.withOpacity(.7),
                                  ),
                                ),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                darkBlueColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.3),
                                blurRadius: 12.0,
                                offset: const Offset(0, 3),
                              )
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                if (_avisController.text.isEmpty) {
                                  Get.snackbar(
                                    "Saisie obligatoire !",
                                    "veuillez entrer votre avis sur le médecin pour effectuer cette opération !",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.black87,
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 4,
                                    borderRadius: 10,
                                    duration: const Duration(seconds: 5),
                                  );
                                  return;
                                }
                                Xloading.showLottieLoading(context);
                                var res = await PatientApi.evaluerMedecin(
                                  key: "avis",
                                  consultId: widget.data.consultationRdvId,
                                  evaluation: _avisController.text,
                                );
                                Xloading.dismiss();
                                print(res);
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.plus_bubble_fill,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            )),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin({String consultationRdvId}) async {
    // update input validation
    await handleCameraAndMic(Permission.camera);
    await handleCameraAndMic(Permission.microphone);

    String uid = storage.read("patient_id");
    String uName = storage.read('patient_name');

    Call call = Call(
        callerId: uid,
        callerName: uName,
        callerPic: "",
        callerType: "patient",
        receiverName: widget.data.medecin.nom,
        receiverPic: widget.data.medecin.photo,
        receiverType: "medecin",
        receiverId: widget.data.medecinId,
        channelId:
            '$uid${widget.data.medecinId}${math.Random().nextInt(1000).toString()}');

    await MedecinApi.consulting(
      key: "start",
      consultId: consultationRdvId,
      consultRef:
          '$uid${widget.data.medecinId}${math.Random().nextInt(1000).toString()}',
    ).then((res) async {
      if (res != null) {
        storage.write("consult_id", res["reponse"]["consultation_id"]);
        await CallMethods.makeCall(call: call);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(
              role: ClientRole.Broadcaster,
              call: call,
              hasCaller: true,
            ),
          ),
        );
      } else {
        XDialog.showConfirmation(
          content: "Cette consultation a été déjà effectuée !",
          title: "Echec de la consultation",
          context: context,
          icon: CupertinoIcons.info,
        );
        return;
      }
    });
  }
}

class CommentSheet extends StatelessWidget {
  final Function onHided;
  const CommentSheet({
    Key key,
    this.onHided,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // ignore: deprecated_member_use
      overflow: Overflow.visible,
      children: [
        Container(
          height: 80.0,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.grey.withOpacity(.4),
                            offset: const Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              style: GoogleFonts.lato(fontSize: 14.0),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                hintText: "Entrez votre commentaire ...",
                                hintStyle: GoogleFonts.lato(color: Colors.grey),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 50.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12.0,
                                    color: Colors.grey.withOpacity(.4),
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_comment,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -25,
          left: 10,
          child: GestureDetector(
            onTap: onHided,
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.4),
                    blurRadius: 12.0,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.clear,
                  color: Colors.red[800],
                  size: 18.0,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CostumIconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onPressed;
  const CostumIconBtn({
    Key key,
    this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: onPressed,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
