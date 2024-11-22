import 'dart:async';

import 'package:challanmcbjava/service/pref_service.dart';
import 'package:get/get.dart';

import '../view/bottombar.dart';
import '../view/login.dart';

class SplashController extends GetxController {
  SplashController();
  final image = "assets/mcb_logo.png";

  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 2), () {
      if (PreferenceUtils.isLoggedIn()) {
        Get.offAll(BottomBar(index: 0,));
      } else {
       Get.offAll(LoginWidget());
      }
    });
    // }
  }
}
