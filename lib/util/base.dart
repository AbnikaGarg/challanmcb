import 'package:challanmcbjava/util/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelp{
    late BuildContext dialogContext;
   static void showLoading([String? message, BuildContext? context]) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
       
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              width: 50,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoActivityIndicator(color: AppColors.maincolor, radius: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  static void hideLoading(context) {
   Navigator.pop(Get.context!);
  }
 
}
