import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import 'index.dart';
import 'screens/home_screen.dart';
import 'screens/home_screen_for_medecin.dart';
import 'services/db_service.dart';
import 'video_calls/permissions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset("assets/lotties/90464-loading.json"),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Shimmer.fromColors(
                      enabled: true,
                      baseColor: primaryColor,
                      highlightColor: Colors.white,
                      child: Text(
                        "SOS docteur",
                        style: GoogleFonts.bowlbyOne(
                          fontSize: 18.0,
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            const Shadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
