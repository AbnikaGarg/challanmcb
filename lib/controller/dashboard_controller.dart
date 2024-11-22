import 'dart:convert';

import 'package:challanmcbjava/models/ChallanModel.dart';
import 'package:challanmcbjava/models/PaymentRecModel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../service/home_service.dart';

class DashboardController extends GetxController {
  DashboardController();

  @override
  void onInit() {
    super.onInit();
    getChallans();
    getReceipts();
    getDashboard(0);
  }

  List<ChallanModel> challanList = [];
  List<Data> challanListData = [];
  List<Data> challanPendingListData = [];
final searchController=TextEditingController();
final searchController2=TextEditingController();

final searchController3=TextEditingController();

  bool isloaded = false;
  void getChallans() async {
    HomepageService().apiGetChallan().then((value) {
      print(value.statusCode);
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.body);
          challanList.clear();
          challanList.add(ChallanModel.fromJson(decodedData));
          if (challanList.isNotEmpty) {
            challanListData = challanList.first.data!;
            challanPendingListData = challanList.first.data!
                .where(
                  (element) => element.paymentReceiveTag == false,
                )
                .toList();
          }
          isloaded = true;
          update();
          break;
        case 401:
          challanList.clear();
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          challanList.clear();
          break;
        default:
          isloaded = true;
          challanListData.clear();
          challanList.clear();
          update();
          break;
      }
    });
  }

  List<PaymentRecModel> receiptList = [];
  List<PaymentRecModelData> receiptDataList = [];
  bool isloadedReceipt = false;
  void getReceipts() async {
    HomepageService().apiGetReceipt().then((value) {
      print(value.statusCode);
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.body);
          receiptList.clear();
          receiptList.add(PaymentRecModel.fromJson(decodedData));
          if (receiptList.isNotEmpty) {
            receiptDataList = receiptList.first.data!;
          }
          isloadedReceipt = true;
          update();
          break;
        case 401:
          receiptList.clear();
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          receiptList.clear();
          break;
        default:
          isloadedReceipt = true;
          receiptList.clear();
          receiptDataList.clear();
          update();
          break;
      }
    });
  }

//PaymentRecModel
  SearchList(String query) async {
    if (query.isNotEmpty) {
      challanListData = challanList.first.data!
          .where((elem) =>
              elem.vehicleNo!.toLowerCase().contains(query) ||
              elem.challanNo!.toLowerCase().contains(query))
          .toList();
    } else {
      challanListData = challanList.first.data!;
    }
    update();
  }

  SearchListPending(String query) async {
    if (query.isNotEmpty) {
      challanPendingListData = challanList.first.data!
          .where((elem) =>
              (elem.vehicleNo!.toLowerCase().contains(query) &&
                  elem.paymentReceiveTag == false) ||
              (elem.challanNo!.toLowerCase().contains(query) &&
                  elem.paymentReceiveTag == false))
          .toList();
    } else {
      getChallans();
    }
    update();
  }

  SearcReceiptList(String query) async {
    if (query.isNotEmpty) {
      receiptDataList = receiptList.first.data!
          .where((elem) =>
              elem.vehicleNo!.toLowerCase().contains(query) ||
              elem.mobileNo!.toLowerCase().contains(query) ||
              elem.challanNo!.toLowerCase().contains(query))
          .toList();
    } else {
      receiptDataList = receiptList.first.data!;
    }
    update();
  }

  onRefresh() {
    isloaded = false;
    update();
    getChallans();
  }

  onRefresh2() {
    isloadedReceipt = false;
    update();
    getReceipts();
    getChallans();
  }

  List responseList = [];
  void getDashboard(type) async {
    HomepageService().apiGetDashboard(type).then((value) {
      print(value.statusCode);
      switch (value.statusCode) {
        case 200:
          responseList = [];
          final decodedData = jsonDecode(value.body);
          responseList = decodedData["data"];
          update();
          break;
        case 401:
          responseList = [];
          Get.offAndToNamed("/login");
          break;
        case 1:
          responseList = [];
          break;
        default:
          responseList = [];
          update();
          break;
      }
    });
  }

  int selectedValue = 0;
  onselect(type) {
    selectedValue = type == 0 ? 0 : 1;
    update();
    getDashboard(type);
  }

  // bool pendingRec = false;
  // onFilterReceipt(value) {
  //   if (value) {
  //     receiptDataList = receiptList.first.data!
  //         .where((elem) => elem.paymentTag == 1)
  //         .toList();
  //   } else {
  //     receiptDataList = receiptList.first.data!;
  //   }
  //   pendingRec = value;
  //   update();
  //   update();
  // }
}
