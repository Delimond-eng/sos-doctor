import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/models/medecins/schedule_model.dart';
import 'package:sos_docteur/utilities/pdf_viewer.dart';
import 'package:sos_docteur/video_calls/models/call_model.dart';
import 'package:sos_docteur/video_calls/pages/call_screen.dart';
import 'package:sos_docteur/video_calls/permissions.dart';
import 'package:sos_docteur/video_calls/resources/call_methods.dart';
import 'package:sos_docteur/widgets/med_shedule_card.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';
import 'dart:math' as math;

import '../../index.dart';

class MedecinScheddulePage extends StatefulWidget {
  const MedecinScheddulePage({Key key}) : super(key: key);

  @override
  _MedecinScheddulePageState createState() => _MedecinScheddulePageState();
}

class _MedecinScheddulePageState extends State<MedecinScheddulePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

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
                  Colors.blue[900],
                  Colors.white.withOpacity(.9),
                  Colors.white.withOpacity(.9),
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
                            "Mes rendez-vous",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (storage.read("isMedecin") == true) UserSession()
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tabHeader(),
                        tabBody(),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget tabBody() {
    return Expanded(
      child: Container(
        child: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: AgendaViewer(
                future: rdvs("encours"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: AgendaViewer(
                future: rdvs("anterieur"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabHeader() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(.4),
          borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BubbleTabIndicator(
          indicatorHeight: 47.0,
          indicatorColor: primaryColor,
          tabBarIndicatorSize: TabBarIndicatorSize.label,
          indicatorRadius: 10,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: GoogleFonts.mulish(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.mulish(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.calendar_today,
                      size: 12.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text("En cours", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.calendar,
                      size: 12.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text("Antérieurs", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<ConsultationsRdv>> rdvs(String type) async {
    var result = await MedecinApi.voirRdvs(key: type);
    if (result != null) {
      var data = result.consultationsRdv;
      return data;
    } else {
      return null;
    }
  }
}

class AgendaViewer extends StatelessWidget {
  final Future<List<ConsultationsRdv>> future;
  const AgendaViewer({Key key, this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<ConsultationsRdv>> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 100,
                  width: 100.0,
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SpinKitWave(
                      color: Colors.black.withOpacity(.8),
                      duration: const Duration(seconds: 1),
                    ),
                  ),
                ),
                const Text("Chargement en cours ...")
              ],
            ),
          );
        } else {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/lotties/5066-meeting-and-stuff.json"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Aucun rendez-vous !",
                    style: GoogleFonts.lato(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scrollbar(
              radius: const Radius.circular(5),
              thickness: 5.0,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    bottom: 60.0, right: 15.0, left: 15.0, top: 10.0),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[index];
                  return MedScheduleCard(
                    data: data,
                    onCalling: () async {
                      // update input validation
                      await handleCameraAndMic(Permission.camera);
                      await handleCameraAndMic(Permission.microphone);

                      String uid = storage.read("medecin_id");
                      String uName = storage.read('medecin_nom');
                      String uPic = storage.read('photo');

                      Call call = Call(
                        callerId: uid,
                        callerName: uName,
                        callerPic: uPic,
                        callerType: "medecin",
                        receiverName: data.nom,
                        receiverPic: "",
                        receiverType: "medecin",
                        receiverId: data.patientId,
                        channelId:
                            '$uid${data.patientId}${math.Random().nextInt(1000).toString()}',
                        consultId: data.consultationRdvId,
                      );
                      Xloading.showLottieLoading(context);
                      await MedecinApi.consulting(
                        consultRef:
                            '$uid${data.patientId}${math.Random().nextInt(1000).toString()}',
                        consultId: data.consultationRdvId,
                        key: "start",
                      ).then((result) async {
                        Xloading.dismiss();
                        print(result);
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
                        /*if (result != null) {
                        
                      } else {
                        Get.snackbar(
                          "Echec de la vidéo conférence !",
                          "une erreur est survenu lors du traitement de l'opération, veuillez reéssayer ultérieurement !",
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.red[200],
                          backgroundColor: Colors.black87,
                          maxWidth: MediaQuery.of(context).size.width - 4,
                          borderRadius: 10,
                        );
                      }*/
                      });
                    },
                    onCancelled: () {
                      showCancellerPdf(
                        context,
                        title: "Annulation du rendez-vous",
                        onValidated: () async {
                          var result = await MedecinApi.annulerRdv(
                              rdvId: data.consultationRdvId);
                          if (result != null) {
                            if (result["reponse"]["status"] == "success") {
                              Get.back();
                              XDialog.showSuccessAnimation(context);
                            }
                          }
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
