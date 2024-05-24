import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableText extends StatelessWidget {
  String text;
  Color? textColor;
  TextDecoration? textDecoration;
  double textSize;
  FontWeight? textFontWeight;
  Color? decorationColor;
  final double? lineThickness; // Add this line
  TextAlign? textAlign;

  ReusableText({
    super.key,
    required this.text,
    required this.textSize,
    this.textFontWeight,
    this.textColor,
    this.textDecoration,
    this.decorationColor,
    this.lineThickness, // Add this line
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: GoogleFonts.nunito(
        fontSize: textSize.sp,
        fontWeight: textFontWeight,
        color: textColor,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: textColor,
        decorationThickness: lineThickness,
      ),
    );
  }
}
