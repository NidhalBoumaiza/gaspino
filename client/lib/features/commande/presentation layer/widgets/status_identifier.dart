import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusIdentifier extends StatelessWidget {
  Color mainColor;
  Color borderColor;
  String textContent;
  Color tectColor;

  StatusIdentifier(
      {super.key,
      required this.borderColor,
      required this.mainColor,
      required this.tectColor,
      required this.textContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
        ),
        color: mainColor,
      ),
      child: Center(
        child: Text(
          '$textContent',
          style: TextStyle(
            color: tectColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
