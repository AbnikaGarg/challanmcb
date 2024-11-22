import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    HapticFeedback.lightImpact();
      Fluttertoast.showToast(
        msg: description!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    // Get.showSnackbar(
    //   GetSnackBar(
    //     icon: Icon(
    //       Icons.close_sharp,
    //       color: Colors.white,
    //     ),
    //     snackStyle: SnackStyle.GROUNDED,
    //     reverseAnimationCurve: Curves.decelerate,
    //     forwardAnimationCurve: Curves.elasticOut,
    //     //padding: EdgeInsets.all(5),

    //     duration: Duration(seconds: 2),
    //     isDismissible: true,

    //     overlayColor: Colors.black,
    //     backgroundColor: Colors.red,
    //     messageText: Text(
    //       description.toString(),
    //       style: Get.theme.textTheme.headlineMedium!
    //           .copyWith(color: AppTheme.whiteTextColor),
    //     ),
    //     // forwardAnimationCurve: Curves.easeIn,
    //     snackPosition: SnackPosition.TOP,
    //   ),
    // );
  }

  hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showSuccess({String? description = 'Saved Successfully'}) {
    HapticFeedback.lightImpact();
    Get.showSnackbar(
      GetSnackBar(
        snackStyle: SnackStyle.GROUNDED,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.bounceOut,
        //padding: EdgeInsets.all(5),

        duration: Duration(seconds: 4),
        isDismissible: true,

        overlayColor: Colors.black,
        backgroundColor: Colors.green,
        messageText: Text(
          description.toString(),
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.headlineMedium!
             
        ),
        // forwardAnimationCurve: Curves.easeIn,
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  static void showAlert2(VoidCallback onCancel, VoidCallback oncntinue,
      {String? buttonname = "Discard",
      String? buttonname2 = "Continue editing",
      String? message = "Are you sure you want to discard?"}) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      padding: EdgeInsets.only(left: 10),
      child: Text(buttonname!),
      onPressed: onCancel,
    );
    Widget continueButton = MaterialButton(
      padding: EdgeInsets.only(right: 16),
      child: Text(
        buttonname2!,
      ),
      onPressed: oncntinue,
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      contentPadding:
          EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      actionsPadding: EdgeInsets.zero,
      content: Text(message!),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showAlertDialog(VoidCallback onTap, {String? title ='Are you sure you want to discard changes you made?'}) {
    Get.dialog(
      //  context: Get.context,//
      CupertinoAlertDialog(
        title: const Text('Discard Changes'),
        insetAnimationCurve: Curves.linear,
        insetAnimationDuration: Duration(milliseconds: 500),
        content: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child:
               Text(title!),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Keep'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: onTap,
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  static void showToast(String des) {
    Fluttertoast.showToast(
        msg: des,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showDeleteDialog(VoidCallback onTap, String title) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(title.toString()),
        insetAnimationCurve: Curves.linear,
        insetAnimationDuration: Duration(seconds: 1),
        content: const Text('Are you sure you want to delete?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: onTap,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}