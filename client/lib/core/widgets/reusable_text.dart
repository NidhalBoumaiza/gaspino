import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableText extends StatelessWidget {
  String text;
  Color? textColor;

  double textSize;
  FontWeight? textFontWeight;

  ReusableText({
    super.key,
    required this.text,
    required this.textSize,
    this.textFontWeight,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        fontSize: textSize.sp,
        fontWeight: textFontWeight,
        color: textColor,
      ),
    );
  }
}
