import 'package:challanmcbjava/controller/challan_controller.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class ChallanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallanController>(() => ChallanController());
  }
}
