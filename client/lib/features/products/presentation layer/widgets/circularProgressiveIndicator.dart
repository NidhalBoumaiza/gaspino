import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ReusablecircularProgressIndicator(
    {Color? indicatorColor, double? height, double? width}) {
  return SizedBox(
    width: width ?? 15.w,
    height: height ?? 15.h,
    child: CircularProgressIndicator(
      color: indicatorColor ?? Colors.black,
    ),
  );
}
