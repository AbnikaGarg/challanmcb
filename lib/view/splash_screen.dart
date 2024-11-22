import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
     backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(58.0),
        child: Image.asset(controller.image, height: 100,),
      )),
    );
  }
}
