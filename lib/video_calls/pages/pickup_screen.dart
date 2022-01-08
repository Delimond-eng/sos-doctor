import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sos_docteur/video_calls/models/call_model.dart';
import 'package:sos_docteur/video_calls/permissions.dart';
import 'package:sos_docteur/video_calls/resources/call_methods.dart';

import '../../index.dart';
import 'call_screen.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({Key key, this.call}) : super(key: key);
  final Call call;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/shapes/cap7.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(.8),
                        Colors.black87.withOpacity(.8)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (call.callerPic.isNotEmpty)
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(call.callerPic)),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.black.withOpacity(.3),
                            offset: const Offset(0, 10.0),
                          )
                        ],
                      ),
                    )
                  else
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/shapes/bg2.png"),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.black.withOpacity(.3),
                            offset: const Offset(0, 10.0),
                          )
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(.5),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Colors.black.withOpacity(.3),
                              offset: const Offset(
                                0,
                                10.0,
                              ),
                            )
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    call.callerName,
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Shimmer(
                    child: Text(
                      "Vidéoconsultation en cours...",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    direction: ShimmerDirection.ltr,
                    enabled: true,
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        Colors.white,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () async {
                      await handleCameraAndMic(Permission.camera);
                      await handleCameraAndMic(Permission.microphone);
                      FlutterRingtonePlayer.stop();
                      await Navigator.push(
                        context,
                        PageTransition(
                          child: CallScreen(
                            call: call,
                            role: ClientRole.Broadcaster,
                          ),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );
                    },
                    child: Icon(
                      CupertinoIcons.phone,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 10,
                    fillColor: Colors.green[700],
                    padding: const EdgeInsets.all(15.0),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      FlutterRingtonePlayer.stop();
                      await CallMethods.endCall(call: call);
                    },
                    child: Icon(
                      CupertinoIcons.phone_down,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 10,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
