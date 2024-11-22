import 'package:challanmcbjava/controller/challan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../components/button.dart';
import '../components/modal_sheet.dart';
import '../components/user_input.dart';
import '../util/app_colors.dart';

class AddChallan extends StatefulWidget {
  AddChallan({super.key});

  @override
  State<AddChallan> createState() => _AddChallanState();
}

class _AddChallanState extends State<AddChallan> {
  final _controller = Get.find<ChallanController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteBackgroundColor,
        elevation: 1,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
        titleSpacing: 0,
        title: Text("Issue Challan",
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 35, 35, 35),
            )),
      ),
      body: GetBuilder<ChallanController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    SizedBox(height: 12),
                    // Center(
                    //   child: Text("Fill all details ",
                    //       style: GoogleFonts.montserrat(
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 14,
                    //           color: Colors.black45)),
                    // ),

                    // /const SizedBox(height: 22),

                    Text(
                      "Vehicle Category",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    DropdownButtonFormField<String>(
                      hint: Text(
                        'Select Vehicle Category',
                        style: GoogleFonts.roboto(fontSize: 15),
                      ),
                      value: controller.categoryId == ""
                          ? null
                          : controller.categoryId,
                      onChanged: (newValue) {
                        controller.categoryId = newValue.toString();
                        List data = controller.categoryList
                            .where((element) =>
                                element["vehicleCategoryId"].toString() ==
                                newValue)
                            .toList();
                        controller.amount.text = data[0]["amount"].toString();
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vehicle Category is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.displaySmall,
                        counterText: '',
                        errorStyle: GoogleFonts.roboto(fontSize: 12),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(225, 30, 61, 1),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintStyle: GoogleFonts.roboto(fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(183, 191, 199, 1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(183, 191, 199, 1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(183, 191, 199, 1),
                              width: 1,
                            )),
                        //illed: true,
                        //  fillColor: fillcolor,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),

                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelStyle: const TextStyle(
                            color: Color.fromRGBO(245, 73, 53, 1)),
                      ),
                      items: controller.categoryList
                          .map<DropdownMenuItem<String>>((dynamic item) {
                        return DropdownMenuItem<String>(
                          value: item['vehicleCategoryId']
                              .toString(), // Example: using ID as the value
                          child: Text(item[
                              'vehicleCategory']), // Example: displaying name in dropdown
                        );
                      }).toList(),
                    ),
                    // MyTextField(
                    //     textEditingController: controller.category,
                    //     validation: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "Vehicle Category is required";
                    //       }
                    //       return null;
                    //     },
                    //     ontap: () {
                    //       ModalSheet.showModal(context, controller.categoryList,
                    //           "vehicleCategory", (value) {
                    //         controller.category.text = value;
                    //       }, (value) {
                    //         controller.categoryId = controller
                    //             .categoryList[value]["vehicleCategoryId"]
                    //             .toString();
                    //         controller.amount.text = controller
                    //             .categoryList[value]["amount"]
                    //             .toString();
                    //       }, controller.category.text);
                    //     },
                    //     hintText: "Select Vehicle Category",
                    //     readOnly: true,
                    //     icon: Icon(Icons.arrow_drop_down,
                    //         color: Color(0xff585A60)),
                    //     color: Color.fromARGB(255, 255, 255, 255)),
                    SizedBox(height: 14),
                    Text(
                      "Challan Reason",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    DropdownButtonFormField<String>(
                      hint: Text(
                        'Select Challan Reason',
                        style: GoogleFonts.roboto(fontSize: 15),
                      ),
                      value: controller.reasonId == ""
                          ? null
                          : controller.reasonId,
                      onChanged: (newValue) {
                        controller.reasonId = newValue.toString();

                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Challan Reason is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.displaySmall,
                        counterText: '',
                        errorStyle: GoogleFonts.roboto(fontSize: 12),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(225, 30, 61, 1),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintStyle: GoogleFonts.roboto(fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(183, 191, 199, 1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(183, 191, 199, 1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(183, 191, 199, 1),
                              width: 1,
                            )),
                        //illed: true,
                        //  fillColor: fillcolor,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        hintText: "hintText",
                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelStyle: const TextStyle(
                            color: Color.fromRGBO(245, 73, 53, 1)),
                      ),
                      items: controller.reasonList
                          .map<DropdownMenuItem<String>>((dynamic item) {
                        return DropdownMenuItem<String>(
                          value: item['challanReasonId']
                              .toString(), // Example: using ID as the value
                          child: Text(item[
                              'challanReason']), // Example: displaying name in dropdown
                        );
                      }).toList(),
                    ),
                    // MyTextField(
                    //     textEditingController: controller.reason,
                    //     validation: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "Challan Reason is required";
                    //       }
                    //       return null;
                    //     },
                    //     ontap: () {
                    //       ModalSheet.showModal(
                    //           context, controller.reasonList, "challanReason",
                    //           (value) {
                    //         controller.reason.text = value;
                    //       }, (value) {
                    //         controller.reasonId = controller.reasonList[value]
                    //                 ["challanReasonId"]
                    //             .toString();
                    //       }, controller.reason.text);
                    //     },
                    //     hintText: "Select Challan Reason",
                    //     readOnly: true,
                    //     icon: Icon(Icons.arrow_drop_down,
                    //         color: Color(0xff585A60)),
                    //     color: Color.fromARGB(255, 255, 255, 255)),
                    SizedBox(height: 14),
                    Text(
                      "Amount",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    MyTextField(
                      hintText: "Enter Amount",
                      textEditingController: _controller.amount,
                      readOnly: true,
                      color: AppColors.whiteBackgroundColor,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Amount is required";
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Vehicle no.",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    SizedBox(
                      height: 2,
                    ),

                    MyTextField(
                      textEditingController: _controller.Vehicleno,
                      hintText: "Enter Vehicle no.",
                      color: AppColors.whiteBackgroundColor,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vehicle no. is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Text(
                    //   "Upload",
                    //   style: GoogleFonts.montserrat(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 14,
                    //       color: Color.fromRGBO(0, 0, 0, 1)),
                    // ),
                    // heightSpace10,

                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon(Icons.upload_outlined),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Upload",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                if (_controller.imagename == "")
                                  Text("Image 1",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 12, height: 1.4))
                                else
                                  Text(_controller.imagename,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 12, height: 1.4)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              _controller.getImage(ImageSource.camera);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.backGround2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: Text("Choose",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(38, 130, 255, 1),
                                        height: 1.4)),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    if (_controller.error)
                      Text(" Image is required",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.red)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon(Icons.upload_outlined),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Upload",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                if (_controller.imagename2 == "")
                                  Text("Image 2",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 12, height: 1.4))
                                else
                                  Text(_controller.imagename2,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 12, height: 1.4)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              _controller.getImage2(ImageSource.camera);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.backGround2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: Text("Choose",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(38, 130, 255, 1),
                                        height: 1.4)),
                              ),
                            ),
                          ),
                        ]),

                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (!_formKey.currentState!.validate() ||
                              _controller.imageProof == null) {
                            _controller.showerror();
                          } else {
                            _controller.addChallan();
                          }
                        },
                        child: CustomButton(
                          title1: "Submit",
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
