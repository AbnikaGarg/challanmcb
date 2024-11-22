import 'package:challanmcbjava/controller/challan_controller.dart';
import 'package:challanmcbjava/controller/receipt_controller.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class ReceiptBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptController>(() => ReceiptController());
  }
}
