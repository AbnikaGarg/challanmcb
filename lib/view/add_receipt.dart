import 'package:challanmcbjava/controller/challan_controller.dart';
import 'package:challanmcbjava/controller/receipt_controller.dart';
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

class AddReceipt extends StatefulWidget {
  AddReceipt({super.key});

  @override
  State<AddReceipt> createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  final _controller = Get.find<ReceiptController>();

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
        title: Text("Receipt",
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 35, 35, 35),
            )),
      ),
      body: GetBuilder<ReceiptController>(builder: (controller) {
        return controller.paymodeList.isEmpty?Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Challan No:",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black45)),
                        Text(controller.challanNo,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black45)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount:",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black45)),
                        Text(controller.amount,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black45)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "Paymode",
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
                        'Select Paymode',
                        style: GoogleFonts.roboto(fontSize: 15),
                      ),
                      value: controller.paymodeId == ""
                          ? null
                          : controller.paymodeId,
                      onChanged: (newValue) {
                        controller.paymodeId = newValue.toString();

                       setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Paymode is required";
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
                      items: controller.paymodeList
                          .map<DropdownMenuItem<String>>((dynamic item) {
                        return DropdownMenuItem<String>(
                          value: item['paymodeId']
                              .toString(), // Example: using ID as the value
                          child: Text(item[
                              'paymode']), // Example: displaying name in dropdown
                        );
                      }).toList(),
                    ),
                    // MyTextField(
                    //     textEditingController: controller.paymode,
                    //     validation: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "Paymode is required";
                    //       }
                    //       return null;
                    //     },
                    //     ontap: () {
                    //       ModalSheet.showModal(
                    //           context, controller.paymodeList, "paymode",
                    //           (value) {
                    //         controller.paymode.text = value;
                    //       }, (value) {
                    //         controller.paymodeId = controller.paymodeList[value]
                    //                 ["paymodeId"]
                    //             .toString();
                    //       }, controller.paymode.text);
                    //     },
                    //     hintText: "Select Paymode",
                    //     readOnly: true,
                    //     icon: Icon(Icons.arrow_drop_down,
                    //         color: Color(0xff585A60)),
                    //     color: Color.fromARGB(255, 255, 255, 255)),
                    SizedBox(height: 14),

                    Text(
                      "Mobile no.",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    SizedBox(
                      height: 2,
                    ),

                    MyTextField(
                      textEditingController: _controller.mobile,
                      hintText: "Enter mobile no.",
                      color: AppColors.whiteBackgroundColor,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mobile no. is required";
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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

                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _controller.addReceipt();
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
