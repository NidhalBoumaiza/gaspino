import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextFieldWidget extends StatelessWidget {
  int? maxLenghtProperty;
  TextAlign? textAlignProperty;
  TextEditingController controller;
  String? hintText;
  void Function()? onPressedSuffixIcon;
  Widget? suffixIcon;
  bool? obsecureText;
  String? errorMessage;
  TextInputType? keyboardType;

  ReusableTextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.onPressedSuffixIcon,
    required this.suffixIcon,
    this.obsecureText,
    this.errorMessage,
    this.keyboardType,
    this.textAlignProperty,
    this.maxLenghtProperty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLength: maxLenghtProperty ?? null,
        textAlign: textAlignProperty ?? TextAlign.start,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obsecureText ?? false,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage ?? 'Ce champ est obligatoire';
          }
          return null;
        },
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          suffixIcon: hintText == 'mot de passe'
              ? IconButton(
                  onPressed: onPressedSuffixIcon,
                  icon: (suffixIcon) ??
                      const Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.sp),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.nunito(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
