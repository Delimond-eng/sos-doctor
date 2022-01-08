import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/models/patients/medecin_data_profil_view_model.dart';
import 'package:sos_docteur/screens/auth_screen.dart';
import 'package:sos_docteur/widgets/user_session_widget.dart';

import '../../index.dart';
import 'doctor_detail_page.dart';

class AvisDetailsPage extends StatefulWidget {
  final String doctorName;
  final List<Avis> avis;
  const AvisDetailsPage({Key key, this.doctorName, this.avis})
      : super(key: key);

  @override
  _AvisDetailsPageState createState() => _AvisDetailsPageState();
}

class _AvisDetailsPageState extends State<AvisDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("patient_id").toString(),
      scaffold: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/shapes/bg3p.png"),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withOpacity(.8), Colors.white54],
                stops: const [0.1, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  buildHeader(context),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        itemCount: widget.avis.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: CommentaireCard(
                              avis: widget.avis[index],
                            ),
                          );
                        },
                      ),
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

  Padding buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
                "Avis sur Dr. ${truncateString(widget.doctorName, 6)}",
                style: style1(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
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
      ),
    );
  }
}
