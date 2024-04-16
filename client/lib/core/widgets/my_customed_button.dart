import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget myCustomedButton(width, height, function, buttonColor, text,
    {double? circularRadious,
    Widget? widget,
    Color? textButtonColor,
    double? fontSize,
    FontWeight? fontWeight}) {
  return SizedBox(
    width: width,
    height: height,
    child: AbsorbPointer(
      absorbing: false,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: buttonColor,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadious ?? 10),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.nunito(
                  color: textButtonColor ?? Colors.white,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  fontSize: fontSize ?? 15,
                  letterSpacing: 0.1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: widget ?? SizedBox(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
