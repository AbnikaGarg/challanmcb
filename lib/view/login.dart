import 'package:challanmcbjava/view/bottombar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbols.dart';
import '../components/user_input.dart';
import '../service/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_colors.dart';
import '../util/base.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 243, 241, 241),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Image.asset(
                    "assets/mcb_logo.png",
                    width: 120,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Municipal Corporation Bathinda",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Text(
                    "Towing Challan",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SignInForm(),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 20.h),
                //   child: const Text(
                //     "Sign Up with Email, Apple or Google",
                //     style: TextStyle(
                //       color: Colors.black54,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Container(
                //       height: 50.0,
                //       width: 50.0,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         border: Border.all(color: Colors.black26),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           decoration: const BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage('assets/google.png'),
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Container(
                //       height: 50.0,
                //       width: 50.0,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         border: Border.all(color: Colors.black26),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           decoration: BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage('assets/apple.png'),
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Container(
                //       height: 50.0,
                //       width: 50.0,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         border: Border.all(color: Colors.black26),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           decoration: const BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage('assets/email.png'),
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                // ],
                //   )
              ]),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool selected = false;
  bool _isValid = false;
  bool iconChange = false;
  final emailController = TextEditingController();
  final password = TextEditingController();
  static const platform = MethodChannel("CallAndriodChannel");
  Future<void> PrintUiFunction() async {
    print("buton click");
    // setState(() {
    //   isTapped = false;
    // });
    // RenderRepaintBoundary boundary;
    // RenderRepaintBoundary boundary2;
    // ui.Image captureImage;
    // try {
    //   String? base64;

    //   boundary =
    //       globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    //   captureImage = await boundary.toImage(pixelRatio: 1.1);

    //   ByteData? byteData =
    //       await captureImage.toByteData(format: ui.ImageByteFormat.png);
    //   Bitmap bitmap = Bitmap.fromHeadless(captureImage.height,
    //       captureImage.width, byteData!.buffer.asUint8List());
    //   setState(() {
    //     base64 = base64Encode(byteData.buffer.asUint8List());
    //     image = captureImage;
    //   });
      final String result =
          await platform.invokeMethod("print", {"encoded": "base64"});
      print('RESULT -> $result');
      if (result == "1") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: const Duration(milliseconds: 1500),
            behavior: SnackBarBehavior.floating,
            width: 200,
            backgroundColor: Colors.black,
            content: Text('Printing......')));
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => BottomBar(
                    index: 0,
                  )),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('$result')));
        setState(() {
        //  isTapped = true;
        });
      }

      // color = result;
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       duration: const Duration(milliseconds: 1000),
    //       behavior: SnackBarBehavior.floating,
    //       backgroundColor: Colors.red,
    //       content: Text('Something went wrong please Wait')));
    //   print(e);
    // }
  }
  Future<void> _submit() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      DialogHelp.showLoading("", context);
      final service = ApiLoginPasswordService();
      service.ApiLoginService(emailController.text, password.text)
          .then((value) {
        DialogHelp.hideLoading(context);
        if (value!=null) {
          if (value["status"] == 1) {
            prefs.setString("Token", value["data"]["token"].toString());
            prefs.setString("name", value["data"]["fullName"].toString());
            prefs.setString("partyid", value["data"]["userId"].toString());
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => BottomBar(
                          index: 0,
                        )),
                (_) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        }else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        final isValid = _formKey.currentState!.validate();
        if (_isValid != isValid) {
          setState(() {
            _isValid = isValid;
          });
        }
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Username",
          style: GoogleFonts.inter(color: Colors.black),
        ),
        MyTextField(
            icon: Icon(CupertinoIcons.mail),
            textEditingController: emailController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Username is required";
              }

              return null;
            },
            hintText: "Enter username",
            color: Color.fromARGB(255, 255, 255, 255)),
        SizedBox(
          height: 10,
        ),
        Text(
          "Password",
          style: GoogleFonts.inter(color: Colors.black),
        ),
        MyTextField(
            icon: Icon(Icons.lock_open_rounded),
            obsecureText: true,
            textEditingController: password,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }

              return null;
            },
            hintText: "*********",
           color: Color.fromARGB(255, 255, 255, 255)),
        Padding(
          padding: EdgeInsets.only(
            top: 30,
          ),
          child: InkWell(
            onTap: () {
              PrintUiFunction();
             //_submit();
            },
            child: Center(
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 1.1,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x430F1113),
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                      color: AppColors.maincolor,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TweenAnimationBuilder<double>(
                      //   tween: Tween(begin: 1.0, end: 0.0),
                      //   duration: const Duration(seconds: 2),
                      //   child: Icon(
                      //     CupertinoIcons.arrow_right,
                      //     color: Colors.white,
                      //   ),
                      //   builder: (context, value, child) {
                      //     return Opacity(opacity: 1);
                      //   },
                      // ),

                      Text(
                        "Sign In",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
            ),
          ),
        ),

        // Padding(
        //   padding: EdgeInsets.only(top: 8, bottom: 24),
        //   child: ElevatedButton.icon(
        //       onPressed: () {
        //         _submit();
        //       },
        //       style: ElevatedButton.styleFrom(
        //           primary: AppColors.maincolor,
        //           minimumSize: Size(double.infinity, 56),
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(25),
        //                   topLeft: Radius.circular(10),
        //                   bottomLeft: Radius.circular(25),
        //                   bottomRight: Radius.circular(25)))),
        //       icon: Icon(CupertinoIcons.arrow_right),
        //       label: Text("Sign In")),
        // ),
        // Row(
        //   children: [
        //     Expanded(child: Divider()),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 10),
        //       child: Text("OR",
        //           style: TextStyle(
        //             color: Colors.black26,
        //           )),
        //     ),
        //     Expanded(child: Divider()),
        //   ],
        // ),
      ]),
    );
  }
}
