import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_docteur/video_calls/models/call_model.dart';

class CallMethods {
  static Future<void> makeCall({Call call}) async {
    try {
      await FirebaseFirestore.instance.collection('call').add(call.toMap());
    } catch (e) {
      print(e);
    }
  }

  static Future<void> endCall({Call call}) async {
    try {
      try {
        FirebaseFirestore.instance
            .collection('call')
            .where('caller_id', isEqualTo: call.callerId)
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((document) async {
            await FirebaseFirestore.instance
                .runTransaction((txn) async => txn.delete(document.reference));
          });
        });
      } catch (err) {
        print("error from delete statment $err");
      }
    } catch (e) {
      print(e);
    }
  }
}
