import 'package:challanmcbjava/controller/dashboard_controller.dart';
import 'package:challanmcbjava/service/pref_service.dart';
import 'package:challanmcbjava/util/app_colors.dart';
import 'package:challanmcbjava/util/app_routes.dart';
import 'package:challanmcbjava/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../components/user_input.dart';
import 'challan_print.dart';

class ChallanReport extends StatelessWidget {
  ChallanReport({super.key});
  final _controller = Get.put<DashboardController>(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backGround2,
        appBar: AppBar(
          backgroundColor: AppColors.backGround2,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          // leading: const Icon(Icons.menu),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date- ${DateFormat("dd MMM yyyy").format(DateTime.now())}",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color.fromRGBO(77, 77, 77, 1)),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Challan Report",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 35, 35, 35),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<DashboardController>(builder: (controller) {
          return !controller.isloaded
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    if (controller.challanListData.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.challanListData.length,
                            shrinkWrap: true,
                            //   primary: false,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 14),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          left: BorderSide(
                                              color: AppColors.maincolor
                                                  .withOpacity(0.5),
                                              width: 9),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.backGround2,
                                              offset: const Offset(0, 0),
                                              blurRadius: 2.0,
                                              spreadRadius: 2),
                                        ],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "${controller.challanListData[index].challanNo} ",
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            if (controller
                                                .challanListData[index]
                                                .paymentReceiveTag!)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xFF83BF6E),
                                                ),
                                                child: Text(
                                                  "Done",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                ),
                                              )
                                            else
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color.fromRGBO(
                                                      212, 203, 68, 1),
                                                ),
                                                child: Text(
                                                  "Pending",
                                                  style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            // else
                                            //   Container(
                                            //     padding: EdgeInsets.symmetric(
                                            //         horizontal: 8, vertical: 4),
                                            //     decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(8),
                                            //       color: Color(0xFF2A85FF),
                                            //     ),
                                            //     child: Text(
                                            //       "To do",
                                            //       style: GoogleFonts.inter(
                                            //           fontSize: 11,
                                            //           fontWeight: FontWeight.w500,
                                            //           color: Colors.white,),
                                            //     ),
                                            //   ),
                                          ],
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("Vehicle No: ",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            Expanded(
                                              child: Text(
                                                " ${controller.challanListData[index].vehicleNo} ",
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.blackColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //                                     static const primary = Color(0xFF2A85FF);
                                        // static const primaryPurple = Color(0xFF8E59FF);
                                        // static const success = Color(0xFF83BF6E);
                                        // static const error = Color(0xFFFF6A55);
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text("Reason: ",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            Text(
                                              " ${controller.challanListData[index].challanReason} ",
                                              style: GoogleFonts.inter(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      43, 48, 52, 1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                            Text("Category: ",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            Text(
                                              " ${controller.challanListData[index].vehicleCategory} ",
                                              style: GoogleFonts.inter(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      43, 48, 52, 1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                            Text("Challan Date: ",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            Text(
                                              ' ${DateFormat("dd MMM yyyy HH:mm a").format(DateTime.parse(controller.challanListData[index].createdDate!))}',
                                              style: GoogleFonts.inter(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      )
                    else
                      Center(
                        child: Text("No Records Found"),
                      )
                  ],
                );
        }),
      ),
    );
  }
}
