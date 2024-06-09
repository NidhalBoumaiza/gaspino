import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/reset_password_step_one_bloc/reset_password_step_one_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/create_new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/widgets/my_customed_button.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../../core/widgets/reusable_text_field_widget.dart';
import '../../../products/presentation layer/widgets/circularProgressiveIndicator.dart';
import '../bloc/forget_password_bloc/forget_password_bloc.dart';

class ResetCodeScreen extends StatelessWidget {
  late String email;

  ResetCodeScreen({super.key, required this.email});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          //appBar: simpleAppBar(),
          body: Container(
            width: 1.sw,
            height: 1.sh,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  ReusableText(
                    text: "Merci de consulter votre email",
                    textSize: 18.sp,
                    textFontWeight: FontWeight.w800,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 5.h),
                  Wrap(
                    children: [
                      ReusableText(
                        text: "nous avons envoyé le code à ",
                        textSize: 12.sp,
                      ),
                      ReusableText(
                        text: email,
                        textSize: 12.sp,
                        textFontWeight: FontWeight.w800,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ReusableTextFieldWidget(
                        maxLenghtProperty: 4,
                        textAlignProperty: TextAlign.center,
                        errorMessage:
                            "Vous devez entrer le code recu par email",
                        hintText: "Code de vérification",
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        suffixIcon: null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0.h),
                    child: BlocConsumer<ResetPasswordStepOneBloc,
                        ResetPasswordStepOneState>(listener: (context, state) {
                      if (state is ResetPasswordStepOneError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ));
                      } else if (state is ResetPasswordStepOneSuccess) {
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                            context,
                            CreateNewPasswordScreen(
                              resetCode: _codeController.text,
                            ));
                      }
                    }, builder: (context, state) {
                      return MyCustomButton(
                        width: double.infinity,
                        height: 50.h,
                        function: state is ForgetPasswordLoading
                            ? () {}
                            : () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  context.read<ResetPasswordStepOneBloc>().add(
                                        ResetPasswordStepOneCodeCheck(
                                            passwordResetCode:
                                                _codeController.text),
                                      );
                                }
                              },
                        buttonColor: primaryColorLight,
                        text: 'Verification',
                        circularRadious: 15.sp,
                        textButtonColor: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w800,
                        widget: state is ResetPasswordStepOneLoading
                            ? ReusablecircularProgressIndicator(
                                indicatorColor: Colors.white,
                              )
                            : const SizedBox(),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
