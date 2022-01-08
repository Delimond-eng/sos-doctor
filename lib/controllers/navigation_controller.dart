import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState.pushNamed(routeName);
  }
  // ignore: missing_return
  Future<dynamic> rootingTo(Widget child){
    return navigationKey.currentState.push(MaterialPageRoute(builder: (context)=>child));
  }

  goBack() => navigationKey.currentState.pop();
}
