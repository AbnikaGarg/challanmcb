import 'dart:convert';
import 'package:bitmap/bitmap.dart';
import 'package:challanmcbjava/models/PaymentRecModel.dart';

import 'package:challanmcbjava/service/pref_service.dart';
import 'package:challanmcbjava/view/bottombar.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:themed/themed.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:google_fonts/google_fonts.dart';

import '../util/app_colors.dart';

class ReceiptPrintpage extends StatefulWidget {
  final PaymentRecModelData data;

  ReceiptPrintpage({Key? key, required this.data}) : super(key: key);

  @override
  State<ReceiptPrintpage> createState() => _PrintpageState();
}

class _PrintpageState extends State<ReceiptPrintpage> {
  GlobalKey<OverRepaintBoundaryState> globalKey = GlobalKey();
  GlobalKey<OverRepaintBoundaryState> globalKey2 = GlobalKey();

  static const platform = MethodChannel("CallAndriodChannel");
  Future<void> PrintUiFunction() async {
    print("buton click");
    setState(() {
      isTapped = false;
    });
    RenderRepaintBoundary boundary;
    RenderRepaintBoundary boundary2;
    ui.Image captureImage;
    try {
      String? base64;

      boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      captureImage = await boundary.toImage(pixelRatio: 1.1);

      ByteData? byteData =
          await captureImage.toByteData(format: ui.ImageByteFormat.png);
      Bitmap bitmap = Bitmap.fromHeadless(captureImage.height,
          captureImage.width, byteData!.buffer.asUint8List());
      setState(() {
        base64 = base64Encode(byteData.buffer.asUint8List());
        image = captureImage;
      });
      final String result =
          await platform.invokeMethod("print", {"encoded": base64});
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
          isTapped = true;
        });
      }

      // color = result;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: const Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Something went wrong please Wait')));
      print(e);
    }
  }

  Future<bool> onWillPop() async {
    Future.delayed(Duration(milliseconds: 400), () {
      Get.offAll(BottomBar(index: 1));
    });

    return false;
  }

  ui.Image? image;
  bool isTapped = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: ColorRef(ui.Color.fromARGB(255, 255, 251, 251)),
        appBar: AppBar(
          backgroundColor: AppColors.backGround2,
          elevation: 1,
          leading: GestureDetector(
            onTap: () {
              onWillPop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
          titleSpacing: 0,
          title: Text("Print Receipt",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 35, 35, 35),
              )),
        ),
        body: ChangeColors(
          hue: 0.55,
          brightness: 0.1,
          saturation: 0.5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Capturer(
                  data: widget.data,
                  overRepaintKey2: globalKey2,
                  overRepaintKey: globalKey,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height / 14.05,
            decoration: BoxDecoration(
                // color: Colors.white,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(20),
                //   topRight: Radius.circular(20),
                // ),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (isTapped) {
                      PrintUiFunction();
                    }
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 14.075,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.print,
                            color: Colors.white,
                          ),
                          Text(
                            '  Print',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NimbusSanL',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )),
      ),
    );
  }
}

class Capturer extends StatefulWidget {
  static final Random random = Random();
  final PaymentRecModelData data;
  final GlobalKey<OverRepaintBoundaryState> overRepaintKey;
  final GlobalKey<OverRepaintBoundaryState> overRepaintKey2;
  const Capturer(
      {Key? key,
      required this.data,
      required this.overRepaintKey,
      required this.overRepaintKey2})
      : super(key: key);

  @override
  State<Capturer> createState() => _CapturerState();
}

class _CapturerState extends State<Capturer> {
  final DateFormat formatter = DateFormat('dd-MMM-yyyy');

  String? Fromdate;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var outputDate = "";
    String string = "";

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            if (widget.data != null)
              Container(
                width: MediaQuery.of(context).size.width,
                child: OverRepaintBoundary(
                  key: widget.overRepaintKey,
                  child: RepaintBoundary(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              ColorRef(ui.Color.fromARGB(255, 255, 251, 251)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/mcb_logo.png',
                                height: 100,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              child: Text(
                                'Municipal Corporation Bathinda',
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                                child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Center(
                                    child: Text(
                                      'Near Railway Station, Bathinda',
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Ph: 1800-180-2626',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Vehicle Payment Receipt',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '(2024-2025)',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Vr No:',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.data.vrNo}',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Vr Date:',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.data.vrDate!.substring(0, 10),
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Challan No:',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.data.challanNo}',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Challan Date:',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.data.createdDate!,
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1, // thickness of the line.

                              color: Colors.black,
                              height: 14, // The divider's height extent.
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Regsitration No:',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.data.vehicleNo}',
                                        style: GoogleFonts.inter(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Mobile No:',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.data.mobileNo}',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1, // thickness of the line.

                              color: Colors.black,
                              height: 14, // The divider's height extent.
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Challan Amount',
                                    style: GoogleFonts.inter(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    'Rs ${widget.data.amount}',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    // maxLines: 3,
                                    textAlign: TextAlign.start,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                'Reason',
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                '${widget.data.challanReason}',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                                // maxLines: 3,
                                textAlign: TextAlign.start,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Divider(
                              thickness: 1, // thickness of the line.

                              color: Colors.black,
                              height: 14, // The divider's height extent.
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'User :',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ' ${PreferenceUtils.getString("name")}',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Print Date',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${DateFormat("dd MMM yyyy HH:mm").format(DateTime.now())}',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              child: Text(
                                'www.mcbathinda.com',
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  decoration: ui.TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 120,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OverRepaintBoundary extends StatefulWidget {
  final Widget child;

  const OverRepaintBoundary({Key? key, required this.child}) : super(key: key);

  @override
  OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
}

class OverRepaintBoundaryState extends State<OverRepaintBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
