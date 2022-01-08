import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import 'data_connection_screen.dart';
import 'index.dart';
import 'screens/home_screen.dart';
import 'screens/home_screen_for_medecin.dart';
import 'services/db_service.dart';
import 'video_calls/permissions.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isMedecin = storage.read("isMedecin") ?? false;

  @override
  void initState() {
    super.initState();
    initLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initLoading() async {
    await handleCameraAndMic(Permission.camera);
    await handleCameraAndMic(Permission.microphone);

    /*var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            child: DataConnectionScreen(),
          ),
          (Route<dynamic> route) => false);
      return;
    }*/
    await DBService.initDb();
    if (isMedecin) {
      await medecinController.refreshDatas();
      await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            alignment: Alignment.topCenter,
            child: MedecinHomeScreen(),
          ),
          (Route<dynamic> route) => false);
      return;
    } else {
      await patientController.refreshDatas();
      await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            alignment: Alignment.topCenter,
            child: HomeScreen(),
          ),
          (Route<dynamic> route) => false);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/shapes/bg4p.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.4),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
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
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Center(
                      child: Shimmer.fromColors(
                        enabled: true,
                        baseColor: primaryColor,
                        highlightColor: Colors.cyan,
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.lato(
                              fontSize: 20.0,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                    color: Colors.black26,
                                    blurRadius: 10.0,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'SOS',
                                style: GoogleFonts.lato(
                                  letterSpacing: 1.20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const TextSpan(text: "  "),
                              TextSpan(
                                text: 'Docteur',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    enabled: true,
                    baseColor: primaryColor,
                    highlightColor: Colors.cyan,
                    child: Container(
                      alignment: Alignment.center,
                      height: 5.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.blue[700],
                          ],
                        ),
                      ),
                    ),
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
