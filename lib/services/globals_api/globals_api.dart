import 'dart:convert';

import 'package:sos_docteur/index.dart';
import 'package:sos_docteur/models/configs_model.dart';

import '../api_service.dart';

class GlobalApi {
  static Future<ContentConfig> viewHomeConfigs() async {
    var response;

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
      return ContentConfig.fromJson(json);
    } else {
      return null;
    }
  }
}
