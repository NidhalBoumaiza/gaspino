import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: simpleAppBar(),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Container(
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: backGroundColorArray,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    ReusableText(
                      text: 'Bonjour',
                      textSize: 30.sp,
                      textFontWeight: FontWeight.w800,
                      textColor: const Color(0xff040003),
                    ),
                    SizedBox(height: 5.h),
                    ReusableText(
                      text: 'Bon retour',
                      textSize: 20.sp,
                      textFontWeight: FontWeight.w500,
                      textColor: const Color(0xff41534e),
                    ),
                    ReusableText(
                      text: 'Tu nous as manqué',
                      textSize: 20.sp,
                      textFontWeight: FontWeight.w500,
                      textColor: const Color(0xff41534e),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
