import 'dart:convert';
import 'dart:io';
import 'package:challanmcbjava/components/base_elements.dart';
import 'package:challanmcbjava/models/PaymentRecModel.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import '../models/ChallanModel.dart';
import '../service/home_service.dart';
import '../service/pref_service.dart';
import '../util/base.dart';
import '../view/bottombar.dart';
import '../view/receipt_print.dart';

class ReceiptController extends GetxController {
  final mobile = TextEditingController();
  // final challanNo = TextEditingController();
  final paymode = TextEditingController();
  final args = Get.arguments;
  String challanNo = "";
  String amount = "";
  @override
  void onInit() {
    super.onInit();

    getPaymode();
    if (args != null) {
      Data data = Get.arguments["data"];
      challanNo = data.challanNo.toString();
      amount = data.amount.toString();
      update();
    }
  }

  List paymodeList = [];
  String paymodeId = "";

  void getPaymode() async {
    HomepageService().apiGetPaymodes().then((value) {
      print(value.statusCode);
      switch (value.statusCode) {
        case 200:
          paymodeList = [];
          final decodedData = jsonDecode(value.body);
          paymodeList = decodedData["data"];
          update();
          break;
        case 401:
          paymodeList = [];
          Get.offAndToNamed("/login");
          break;
        case 1:
          paymodeList = [];
          break;
        default:
          paymodeList = [];
          update();
          break;
      }
    });
  }

  void addReceipt() {
    DialogHelp.showLoading("");

    HomepageService()
        .apiAddReceipt(
            double.parse(amount), int.parse(paymodeId), mobile.text, challanNo)
        .then((value) {
      DialogHelp.hideLoading("");
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.body);
          DialogHelper.showErroDialog(description: "Submit Successfully");
          // Get.offAll(BottomBar(
          //   index: 1,
          // ));
          List<PaymentRecModel> data = [];
          data.add(PaymentRecModel.fromJson(decodedData));

          Get.to(ReceiptPrintpage(
            data: data[0].data!.first,
          ));
          break;
        // case 1:

        //   break;
        default:
          break;
      }
    });
  }
}
