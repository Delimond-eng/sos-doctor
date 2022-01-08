import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:sos_docteur/video_calls/models/call_model.dart';

import '../../index.dart';
import 'pickup_screen.dart';

class PickupLayout extends StatelessWidget {
  const PickupLayout({Key key, this.uid, this.scaffold}) : super(key: key);
  final String uid;
  final Widget scaffold;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FlutterRingtonePlayer.stop();
        return Future.value(true);
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('call')
            .where('receiver_id', isEqualTo: uid)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
            var data = snapshot.data.docs[0].data();
            Call call = Call.fromMap(data);
            if (call.receiverId == uid) {
              FlutterRingtonePlayer.play(
                android: AndroidSounds.ringtone,
                ios: IosSounds.triTone,
                looping: true, // Android only - API >= 28
                volume: 0.1, // Android only - API >= 28
                asAlarm: false, // Android only - all APIs
              );
              return PickUpScreen(
                call: call,
              );
            }
          }
          FlutterRingtonePlayer.stop();
          return scaffold;
        },
      ),
    );
  }
}
