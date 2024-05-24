import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/reusable_text.dart';
import '../../../../core/widgets/reusable_text_field_widget.dart';

class RecoveryDateWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  RecoveryDateWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                  text: "Prix original:",
                  textSize: 15.sp,
                  textColor: Colors.grey[700]!,
                  textFontWeight: FontWeight.w600),
              SizedBox(height: 5.h),
              ReusableTextFieldWidget(
                textAlignProperty: TextAlign.center,
                controller: controller,
                hintText: "Prix original",
                borderSide: const BorderSide(color: Colors.grey),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                  text: "Prix de vente:",
                  textSize: 15.sp,
                  textColor: Colors.grey[700]!,
                  textFontWeight: FontWeight.w600),
              SizedBox(height: 5.h),
              ReusableTextFieldWidget(
                textAlignProperty: TextAlign.center,
                controller: controller,
                hintText: "Prix de vente",
                borderSide: const BorderSide(color: Colors.grey),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
