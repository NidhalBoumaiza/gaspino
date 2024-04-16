import 'package:client/features/authorisation/presentation%20layer/bloc/reset_password_step_two_bloc/reset_password_step_two_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/strings.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/my_customed_button.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../../core/widgets/reusable_text_field_widget.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  String resetCode;

  CreateNewPasswordScreen({Key? key, required this.resetCode})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: simpleAppBar(),
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
                    text: "créer un nouveau mot de passe",
                    textSize: 18.sp,
                    textFontWeight: FontWeight.w800,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 5.h),
                  ReusableText(
                    text:
                        "ce mot de passe doit être une différence de l'ancien mot de passe",
                    textSize: 12.sp,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ReusableTextFieldWidget(
                            errorMessage:
                                "Vous devez entrer votre mot de passe",
                            hintText: "Mot de passe",
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            suffixIcon: null,
                          ),
                          ReusableTextFieldWidget(
                            errorMessage:
                                "Vous devez confirmer votre mot de passe",
                            hintText: "Confirmer mot de passe",
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.text,
                            suffixIcon: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0.h),
                    child: BlocConsumer<ResetPasswordStepTwoBloc,
                        ResetPasswordStepTwoState>(listener: (context, state) {
                      if (state is ResetPasswordStepTwoError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (state is ResetPasswordStepTwoSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(PasswordResetedSuccessMessage),
                          backgroundColor: Colors.green,
                        ));
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                          context,
                          SignInScreen(),
                        );
                      }
                    }, builder: (context, state) {
                      return myCustomedButton(
                        double.infinity,
                        50.h,
                        state is ResetPasswordStepTwoLoading
                            ? () {}
                            : () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  context.read<ResetPasswordStepTwoBloc>().add(
                                      ResetPasswordStepTwoReset(
                                          passwordResetCode: resetCode,
                                          password: _passwordController.text,
                                          passwordConfirm:
                                              _confirmPasswordController.text));
                                }
                              },
                        primaryColorLight,
                        'réinitialiser',
                        circularRadious: 15.sp,
                        textButtonColor: Colors.black,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w800,
                        widget: state is ResetPasswordStepTwoLoading
                            ? circularProgressIndicator()
                            : SizedBox(),
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