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
import '../cubit/confirm_password_visibility_reset_password_cubit/reset_confirm_password_visibility_cubit.dart';
import '../cubit/password_visibility_reset_password_cubit/reset_password_visibility_cubit.dart';

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
                        "N'hésiter pas de saisir une mot de passe bien sécurisé pour la sécurité de votre compte.",
                    textSize: 12.sp,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BlocBuilder<ResetPasswordVisibilityCubit,
                              ResetPasswordVisibilityState>(
                            builder: (context, state) {
                              return ReusableTextFieldWidget(
                                errorMessage:
                                    "Vous devez entrer un mot de passe",
                                obsecureText: !state.isVisible,
                                controller: _passwordController,
                                hintText: "mot de passe",
                                onPressedSuffixIcon: () {
                                  context
                                      .read<ResetPasswordVisibilityCubit>()
                                      .changeVisibility();
                                },
                                suffixIcon: state.isVisible
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                              );
                            },
                          ),
                          BlocBuilder<ResetConfirmPasswordVisibilityCubit,
                              ResetConfirmPasswordVisibilityState>(
                            builder: (context, state) {
                              return ReusableTextFieldWidget(
                                errorMessage:
                                    "Vous devez confirmer votre mot de passe",
                                obsecureText: !state.isVisible,
                                controller: _confirmPasswordController,
                                hintText: "Confirmer mot de passe",
                                onPressedSuffixIcon: () {
                                  context
                                      .read<
                                          ResetConfirmPasswordVisibilityCubit>()
                                      .changeVisibility();
                                },
                                suffixIcon: state.isVisible
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                              );
                            },
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
