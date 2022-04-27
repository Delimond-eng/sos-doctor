import 'dart:async';

import 'package:flutter/cupertino.dart';

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
      medecinController.refreshDatas();
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            alignment: Alignment.topCenter,
            child: const MedecinHomeScreen(),
          ),
          (Route<dynamic> route) => false);
      return;
    } else {
      patientController.refreshDatas();
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            alignment: Alignment.topCenter,
            child: const HomeScreen(),
          ),
          (Route<dynamic> route) => false);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
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
                color: Colors.white.withOpacity(.9),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(
                      child: SpinKitChasingDots(
                        color: Colors.black,
                        size: 30.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Center(
              child: Image.asset(
                "assets/icons/ic_icon_transparent.png",
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
