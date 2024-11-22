import 'package:challanmcbjava/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  String hintText;
  var color;
  var fillcolor;
  var icon;
  var preicon;
  bool readOnly;
  var validation;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  var ontap;
  var ontapSuffix;
  final ValueChanged<String>? onChanged;
  bool autofocus;
  final bool obsecureText;
  final bool isSuffixIcon;
  final TextEditingController? textEditingController;
  MyTextField(
      {super.key,
      required this.hintText,
      required this.color,
      this.icon,
      this.fillcolor = Colors.white,
      this.ontapSuffix,
      this.obsecureText = false,
      this.isSuffixIcon = false,
      this.readOnly = false, this.autofocus = false,
      this.preicon,
      this.ontap,
      this.textInputType,
      this.inputFormatters,
      this.textEditingController,
      this.validation, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 8),
      child: TextFormField(
          keyboardType: textInputType,
          onTap: ontap,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          controller: textEditingController,
          obscureText: obsecureText,
          validator: validation,
          onChanged: onChanged,
          cursorColor: AppColors.maincolor,
          // cursorHeight: 20.h,
          //  textAlignVertical: TextAlignVertical.center,
autofocus: autofocus,
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
              contentPadding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              hintText: hintText,
              fillColor: color,
              filled: true,
              floatingLabelStyle:
                  const TextStyle(color: Color.fromRGBO(245, 73, 53, 1)),
              suffixIcon: isSuffixIcon
                  ? GestureDetector(
                      child: !obsecureText
                          ? Icon(
                              Icons.visibility_off,
                              size: 18,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.visibility,
                              size: 18,
                              color: Colors.grey,
                            ),
                      onTap: ontapSuffix,
                    )
                  : icon)),
    );
  }
}
