import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sos_docteur/index.dart';
import 'package:sos_docteur/utilities/config.dart' as config;
import 'package:sos_docteur/video_calls/models/call_model.dart';
import 'package:sos_docteur/video_calls/resources/call_methods.dart';

class CallScreen extends StatefulWidget {
  /// non-modifiable channel name of the page
  final Call call;

  /// non-modifiable client role of the page
  final ClientRole role;

  final bool hasCaller;

  /// Creates a call page with given channel name.
  const CallScreen({
    Key key,
    this.role,
    this.call,
    this.hasCaller = false,
  }) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool camerahasSwitched = false;
  RtcEngine _engine;

  StreamSubscription<QuerySnapshot> _callStreamSubscription;

  @override
  void dispose() {
    super.dispose();
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    _callStreamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (config.appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _initCallStreamer();
    _addAgoraEventHandlers();
    // ignore: deprecated_member_use
    await _engine.enableWebSdkInteroperability(true);
    await _engine.joinChannel(null, widget.call.channelId, null, 0);
  }

  _initCallStreamer() async {
    try {
      _callStreamSubscription = FirebaseFirestore.instance
          .collection('call')
          .where('caller_id', isEqualTo: widget.call.callerId)
          .snapshots(includeMetadataChanges: true)
          .listen((data) async {
        //var userData = data.docs[0].data();
        //Call call = Call.fromMap(userData);
        //print("ringtone play ${call.receiverId}");
        if (data.docs.isEmpty) {
          print("user has disconnected !");
          XDialog.showConfirmation(
              content: "Vidéoconsultation terminée !",
              context: context,
              icon: Icons.offline_share,
              title: "Reception rejetée",
              onCancel: () async {
                await Get.back();
                await Get.back();
                FlutterRingtonePlayer.stop();
              });
        }
      });
    } catch (error) {
      print("error from call stream subscription !");
    }
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(config.appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width} x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(
        RtcLocalView.SurfaceView(),
      );
    }
    _users.forEach((uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      flex: 5,
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? CupertinoIcons.mic_off : CupertinoIcons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 25.0,
            ),
            shape: CircleBorder(),
            elevation: 10,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {
              FlutterRingtonePlayer.stop();
              _onCallEnd(context);
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
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: camerahasSwitched
                ? Icon(
                    CupertinoIcons.camera_rotate_fill,
                    color: Colors.white,
                    size: 25.0,
                  )
                : Icon(
                    CupertinoIcons.camera_rotate,
                    color: primaryColor,
                    size: 25.0,
                  ),
            shape: CircleBorder(),
            elevation: 10,
            fillColor: camerahasSwitched ? primaryColor : Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return Text(
                    "null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) async {
    Xloading.showLottieLoading(context);
    await MedecinApi.consulting(consultId: widget.call.consultId, key: "end");
    Xloading.dismiss();
    await CallMethods.endCall(call: widget.call);
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    setState(() {
      camerahasSwitched = !camerahasSwitched;
    });
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (widget.hasCaller == true && _getRenderViews().length == 1)
          ? pickupScreen()
          : (_getRenderViews().length > 1)
              ? callScreens()
              : waitingCallScreen(context),
    );
  }

  Widget callScreens() {
    return Center(
      child: Stack(
        children: <Widget>[
          Center(child: _getRenderViews()[1] ?? _getRenderViews()[0]),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10.0, top: 35.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 12.0,
                    offset: const Offset(0.0, 10.0),
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 4,
              child: _getRenderViews()[0],
            ),
          ),
          _toolbar(),
        ],
      ),
    );
  }

  Widget waitingCallScreen(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.black45, Colors.black87])),
              child: const Center(
                child: SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10.0, top: 35.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black87,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    blurRadius: 12.0,
                    offset: const Offset(0.0, 10.0),
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 4,
              child: const Center(
                child: SpinKitWave(
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          ),
          _toolbar(),
        ],
      ),
    );
  }

  Widget pickupScreen() {
    return Center(
      child: Stack(
        children: <Widget>[
          Center(
            child: _getRenderViews()[0],
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
                if (widget.call.receiverPic.isEmpty)
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
                  )
                else
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(
                          base64Decode(widget.call.receiverPic),
                        ),
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
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.call.receiverName,
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
                  onPressed: () {
                    FlutterRingtonePlayer.stop();
                    _onCallEnd(context);
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
    );
  }
}
