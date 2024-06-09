import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/reusable_text.dart';

class ReusableListTile extends StatelessWidget {
  String text;
  IconData? icon;
  void Function()? onTap;
  Color? textColor;
  FontWeight? textFontWeight;
  int textSize;
  double? paddingLeft;
  double? iconSize;
  IconData? leadingIcon;

  ReusableListTile({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.textColor,
    this.textFontWeight,
    required this.textSize,
    this.paddingLeft,
    this.iconSize,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ReusableText(
        text: text,
        textSize: textSize!.sp,
        textColor: textColor,
        textFontWeight: textFontWeight,
      ),
      leading: icon != null
          ? Padding(
              padding: EdgeInsets.only(left: paddingLeft ?? 20.0.w),
              child: Icon(
                icon,
                color: textColor,
                size: iconSize?.sp,
              ),
            )
          : null,
      trailing: leadingIcon != null
          ? Icon(
              Icons.arrow_forward_ios,
              color: textColor,
            )
          : null,
      onTap: onTap,
    );
  }
}
