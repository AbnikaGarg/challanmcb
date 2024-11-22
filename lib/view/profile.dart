import 'package:challanmcbjava/service/pref_service.dart';
import 'package:challanmcbjava/view/challan_report.dart';
import 'package:challanmcbjava/view/login.dart';
import 'package:challanmcbjava/view/receipt_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/dashboard_controller.dart';
import '../util/app_colors.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  List filterData = [
    {"text": "All", "value": 0},
    {"text": "Current", "value": 1},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGround2,
        appBar: AppBar(
          backgroundColor: AppColors.whiteBackgroundColor,
          elevation: 1,
          titleSpacing: 20,
          centerTitle: false,
          // leading: const Icon(Icons.menu),
          title: Text(
            "Profile",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 35, 35, 35),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();

                preferences.clear();

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          width: 50,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CupertinoActivityIndicator(
                                color: AppColors.primaryColor, radius: 14),
                          ),
                        ),
                      ],
                    );
                  },
                );
                await Future.delayed(Duration(seconds: 1));
                Navigator.of(context).pushAndRemoveUntil(
                  // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginWidget(),
                  ),
                  (Route route) => false,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFFF6A55),
                ),
                child: Text(
                  "Logout",
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            )
          ],
        ),
        body: GetBuilder<DashboardController>(builder: (controller) {
          return SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Filter:  ",
                              style: GoogleFonts.inter(height: 0),
                            ),
                            Wrap(
                              children: List.generate(
                                filterData.length,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (filterData[index]["value"] == 1) {
                                        controller.onselect(int.parse(
                                            PreferenceUtils.getString(
                                                "partyid")));
                                      } else {
                                        controller.onselect(
                                            filterData[index]["value"]);
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 2, right: 8, bottom: 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.whiteBackgroundColor,
                                          border: Border.all(
                                              color: controller.selectedValue ==
                                                      filterData[index]["value"]
                                                  ? Color.fromRGBO(
                                                      34, 225, 193, 1)
                                                  : AppColors
                                                      .whiteBackgroundColor
                                                      .withOpacity(0.6)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "${filterData[index]["text"]}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.blackColor),
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        controller.responseList.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : GridView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2 / 1.05,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 12),
                                children: [
                                    buildCard(
                                      "Total Challan",
                                      "${controller.responseList[0]["todayChallanCount"]}",
                                      FontAwesomeIcons.chartSimple,
                                    ),
                                    buildCard(
                                        "Challan Amount",
                                        "${controller.responseList[0]["todayChallanTotal"]}",
                                        FontAwesomeIcons.moneyBills),
                                    buildCard(
                                      "Total Receipt",
                                      "${controller.responseList[0]["todayRecCount"]}",
                                      FontAwesomeIcons.chartSimple,
                                    ),
                                    buildCard(
                                        "Total Rec Amount",
                                        "${controller.responseList[0]["todayRecTotal"]}",
                                        FontAwesomeIcons.moneyBills),
                                    buildCard(
                                        "Receipt Cash",
                                        "${controller.responseList[0]["todayRecCash"]}",
                                        FontAwesomeIcons.moneyBills),
                                    buildCard(
                                      "Receipt Online",
                                      "${controller.responseList[0]["todayRecOnline"]}",
                                      FontAwesomeIcons.moneyBills,
                                    ),
                                  ]),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ChallanReport());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(139, 151, 151, 155)
                                          .withOpacity(0.1),
                                      offset: Offset(1, 1),
                                      blurRadius: 2.0,
                                      spreadRadius: 2),
                                ],
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.whiteBackgroundColor),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              child: Row(
                                //art,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Challan Report",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                       GestureDetector(
                          onTap: () {
                            Get.to(ReceiptReport());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(139, 151, 151, 155)
                                          .withOpacity(0.1),
                                      offset: Offset(1, 1),
                                      blurRadius: 2.0,
                                      spreadRadius: 2),
                                ],
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.whiteBackgroundColor),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              child: Row(
                                //art,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Receipt Report",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ])));
        }));
  }

  buildCard(String title, String count, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(139, 151, 151, 155).withOpacity(0.1),
                offset: Offset(1, 1),
                blurRadius: 2.0,
                spreadRadius: 2),
          ],
          borderRadius: BorderRadius.circular(12),
          color: AppColors.whiteBackgroundColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  count.toString(),
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor),
                ),
                Spacer(),
                FaIcon(
                  icon,
                  size: 22,
                  color: AppColors.hintTextColor,
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Flexible(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
