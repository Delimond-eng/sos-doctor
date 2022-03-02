import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/models/medecins/medecin_profil.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';

import '../../index.dart';
import 'medecin_agenda_config.dart';

class MedecinAgendaPageView extends StatefulWidget {
  const MedecinAgendaPageView({Key key}) : super(key: key);

  @override
  _MedecinAgendaPageViewState createState() => _MedecinAgendaPageViewState();
}

class _MedecinAgendaPageViewState extends State<MedecinAgendaPageView> {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("medecin_id").toString(),
      scaffold: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/shapes/bg5p.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(.5),
                  Colors.white.withOpacity(.8),
                  Colors.white.withOpacity(.8),
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
                              "Mon agenda",
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
                    child: Obx(() {
                      return Container(
                        child: medecinController
                                .medecinProfil.value.datas.profilAgenda.isEmpty
                            ? Center(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20.0),
                                  height: 70.0,
                                  width: MediaQuery.of(context).size.width,
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    color: Colors.blue[800],
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          alignment: Alignment.topCenter,
                                          curve: Curves.easeIn,
                                          child:
                                              const MedecinAgendaConfigPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Configurer votre agenda",
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: medecinController.medecinProfil.value
                                    .datas.profilAgenda.length,
                                itemBuilder: (context, index) {
                                  var data = medecinController.medecinProfil
                                      .value.datas.profilAgenda[index];
                                  return AgendaCard(
                                    heures: data.heures,
                                    date: data.date,
                                    onRemoved: () async {
                                      XDialog.show(
                                        context: context,
                                        icon: Icons.help_rounded,
                                        content:
                                            "Etes-vous sûr de vouloir supprimer définitivement votre ce rendez-vous ?",
                                        title: "Suppression rdv!",
                                        onValidate: () async {
                                          Get.back();
                                        },
                                      );
                                    },
                                  );
                                },
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
}

class AgendaCard extends StatelessWidget {
  final String date;
  final List<HeuresDispo> heures;
  final Function onRemoved;
  const AgendaCard({
    Key key,
    this.date,
    @required this.heures,
    this.onRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // ignore: deprecated_member_use
      overflow: Overflow.visible,
      children: [
        Container(
          height: 110.0,
          margin: const EdgeInsets.only(bottom: 8.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white.withOpacity(.8),
            boxShadow: [
              BoxShadow(
                blurRadius: 12.0,
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/schedule-svgrepo-com.svg",
                        color: Colors.white,
                        height: 50.0,
                        width: 50.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${strDateLongFr(date)} ",
                          style: GoogleFonts.lato(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if (heures != null) ...[
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < heures.length; i++) ...[
                                  TimeCard(
                                    start: heures.first.heure,
                                    end: heures.last.heure,
                                  )
                                ]
                              ],
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 8,
          child: GestureDetector(
            onTap: onRemoved,
            child: Container(
              height: 30.0,
              width: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[800],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.4),
                    blurRadius: 12.0,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  "Annuler",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TimeCard extends StatelessWidget {
  final String start, end;
  const TimeCard({
    Key key,
    this.start,
    this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.7),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.time_solid,
                color: primaryColor,
                size: 16.0,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                start,
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
          Container(
            width: 15.0,
            height: 2,
            color: primaryColor,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.time_solid,
                color: Colors.cyan[800],
                size: 16.0,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                end,
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
