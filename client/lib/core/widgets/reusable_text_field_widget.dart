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
  BorderSide? borderSide;
  int? maxLines;
  int? minLines;
  IconData? prefixIcon;
  void Function()? onPressedPreffixIcon;
  Color? prefixIconColor;
  bool? enabled;
  double? paddingValue;
  String? Function(String?)? validatorFunction;

  TextInputAction? textInputAction;
  void Function()? onEditingComplete;

  ReusableTextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.onPressedSuffixIcon,
    this.suffixIcon,
    this.obsecureText,
    this.errorMessage,
    this.keyboardType,
    this.textAlignProperty,
    this.maxLenghtProperty,
    this.borderSide,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.onPressedPreffixIcon,
    this.prefixIconColor,
    this.enabled,
    this.paddingValue,
    this.validatorFunction,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingValue ?? 8.0),
      child: TextFormField(
        textInputAction: textInputAction,
        enabled: enabled ?? true,
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        maxLength: maxLenghtProperty,
        textAlign: textAlignProperty ?? TextAlign.start,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obsecureText ?? false,
        controller: controller..text,
        onEditingComplete: onEditingComplete,
        validator: validatorFunction ??
            (value) {
              if (value == null || value.isEmpty) {
                return errorMessage ?? 'Ce champ est obligatoire';
              }
              return null;
            },
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon != null
              ? IconButton(
                  onPressed: onPressedPreffixIcon,
                  icon: Icon(prefixIcon),
                  color: prefixIconColor ?? null,
                )
              : null,
          suffixIcon: obsecureText != null || suffixIcon != null
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
            borderSide: borderSide ?? BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.sp),
            borderSide: borderSide ?? BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.sp),
            borderSide: borderSide ?? BorderSide.none,
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
