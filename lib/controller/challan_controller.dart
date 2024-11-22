import 'dart:convert';
import 'dart:io';
import 'package:challanmcbjava/components/base_elements.dart';
import 'package:challanmcbjava/models/ChallanModel.dart';
import 'package:challanmcbjava/view/challan_print.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import '../service/home_service.dart';
import '../service/pref_service.dart';
import '../util/base.dart';
import '../view/bottombar.dart';

class ChallanController extends GetxController {
  final amount = TextEditingController();
  final Vehicleno = TextEditingController();
  final category = TextEditingController();
  final reason = TextEditingController();
  String imagename = "";
  File? imageProof;
  String imagename2 = "";
  File? imageProof2;
  bool error = false;
  @override
  void onInit() {
    super.onInit();
    getCategory();
    getReason();
  }

  Future getImage(ImageSource img) async {
    try {
      final image = await ImagePicker().pickImage(
        source: img,
      );
      if (image == null) return;

      final imageTemp = File(
        image.path,
      );
      //if (!mounted) return;
      // setState(() {
      imageProof = imageTemp;
      imagename = image.name;
      error = false;
      update();
      //   _postController.checkText.value = true;
      // });
    } on PlatformException catch (e) {}
  }

  Future getImage2(ImageSource img) async {
    try {
      final image = await ImagePicker().pickImage(
        source: img,
      );
      if (image == null) return;

      final imageTemp = File(
        image.path,
      );
      //if (!mounted) return;
      // setState(() {
      imageProof2 = imageTemp;
      imagename2 = image.name;

      update();
      //   _postController.checkText.value = true;
      // });
    } on PlatformException catch (e) {}
  }

  showerror() {
    error = true;
    update();
  }

  List categoryList = [];
  String categoryId = "";
  List reasonList = [];
  String reasonId = "";
  void getCategory() async {
    HomepageService().apiGetCategory().then((value) {
      print(value.statusCode);
      switch (value.statusCode) {
        case 200:
          categoryList = [];
          final decodedData = jsonDecode(value.body);
          categoryList = decodedData["data"];
          update();
          break;
        case 401:
          categoryList = [];
          Get.offAndToNamed("/login");
          break;
        case 1:
          categoryList = [];
          break;
        default:
          categoryList = [];
          update();
          break;
      }
    });
  }

  void getReason() async {
    HomepageService().apiGetReasons().then((value) {
      print(value.statusCode);
      switch (value.statusCode) {
        case 200:
          reasonList = [];
          final decodedData = jsonDecode(value.body);
          reasonList = decodedData["data"];
          update();
          break;
        case 401:
          reasonList = [];
          Get.offAndToNamed("/login");
          break;
        case 1:
          reasonList = [];
          break;
        default:
          reasonList = [];
          update();
          break;
      }
    });
  }

  void addChallan() {
    DialogHelp.showLoading("");
    String img64 = "";
    String img642 = "";
    if (imageProof != "" && imageProof != null) {
      final bytes = io.File(imageProof!.path).readAsBytesSync();

      img64 = base64Encode(bytes);
    }
    if (imageProof2 != "" && imageProof2 != null) {
      final bytes = io.File(imageProof2!.path).readAsBytesSync();

      img642 = base64Encode(bytes);
    }
    HomepageService()
        .apiAddChallan(int.parse(amount.text), int.parse(reasonId),
            int.parse(categoryId), Vehicleno.text, img64, img642)
        .then((value) {
      DialogHelp.hideLoading("");
      switch (value.statusCode) {
        case 200:
          final decodedData = jsonDecode(value.body);
          List<ChallanModel> data = [];
          data.add(ChallanModel.fromJson(decodedData));

          DialogHelper.showErroDialog(description: "Challan Issued");
          Get.to(Printpage(
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
