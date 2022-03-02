import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sos_docteur/controllers/medecin_controller.dart';
import 'package:sos_docteur/controllers/session_controller.dart';
import 'package:sos_docteur/splash_screen.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/patient_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Firebase.initializeApp();
  await GetStorage.init();
  Get.put(NavigationController());
  Get.put(SessionController());
  Get.put(MedecinController());
  Get.put(PatientController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      defaultTransition: Transition.fade,
      popGesture: Get.isPopGestureEnable,
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [const Locale('fr', 'FR')],
      theme: ThemeData(
          primaryColor: Colors.blue[800],
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white),
      home: const SplashScreen(),
    );
  }
}
