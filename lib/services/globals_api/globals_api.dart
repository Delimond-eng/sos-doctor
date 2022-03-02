import 'dart:convert';

import 'package:sos_docteur/index.dart';
import 'package:sos_docteur/models/configs_model.dart';

import '../api_service.dart';

class GlobalApi {
  static Future<ContentConfig> viewHomeConfigs() async {
    var response;
    DateTime _now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int nowTimestamp = _now.microsecondsSinceEpoch;

    if (storage.read('${nowTimestamp}configs') == null) {
      try {
        response = await DApi.request(
          method: "get",
          url: "/content/config",
        );
      } catch (err) {
        print("error from annulation consultation $err");
      }
      if (response != null) {
        var json = jsonDecode(response);

        if (json["error"] != null) {
          return null;
        }
        storage.write('${nowTimestamp}configs', json);
        return ContentConfig.fromJson(json);
      } else {
        return null;
      }
    } else {
      DateTime _lastDate = _now.subtract(const Duration(days: 1));
      int _lastTimestamp = _lastDate.microsecondsSinceEpoch;
      //print(_lastTimestamp);
      storage.remove('${_lastTimestamp}configs');
      var data = storage.read('${nowTimestamp}configs');
      return ContentConfig.fromJson(data);
    }
  }
}
