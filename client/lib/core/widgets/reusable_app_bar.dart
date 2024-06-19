import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;
  final Color? textColor;
  final FontWeight? textFontWeight;
  final double? textSize;
  final Color? appBarColor;
  final IconData? leadingIcon;

  ReusableAppBar({
    Key? key,
    required this.pageName,
    this.textColor,
    this.textFontWeight,
    this.textSize,
    this.appBarColor,
    this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            leadingIcon ?? Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: ReusableText(
          text: pageName,
          textSize: textSize?.sp ?? 18.sp,
          textColor: textColor ?? Colors.white,
          textFontWeight: textFontWeight ?? FontWeight.w800,
        ),
        backgroundColor: appBarColor ?? primaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
