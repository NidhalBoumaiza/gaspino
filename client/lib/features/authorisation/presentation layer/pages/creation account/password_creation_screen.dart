import 'package:client/features/authorisation/presentation%20layer/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../../../../core/widgets/reusable_text_field_widget.dart';
import '../../../../../core/widgets/simple_app_bar.dart';
import '../../../../products/presentation layer/widgets/circularProgressiveIndicator.dart';
import '../../../domain layer/entities/user.dart';
import '../../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../cubit/confirm_password_visibility_reset_password_cubit/reset_confirm_password_visibility_cubit.dart';
import '../../cubit/password_visibility_reset_password_cubit/reset_password_visibility_cubit.dart';

class PasswordCreationScreen extends StatelessWidget {
  late User user;

  PasswordCreationScreen({super.key, required this.user});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  dynamic bytes;

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
                  SizedBox(height: 80.h),
                  ReusableText(
                    text: "Créer votre mot de passe",
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
                    flex: 0,
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
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0.h),
                    child: BlocConsumer<SignUpBloc, SignUpState>(
                        listener: (context, state) {
                      if (state is SignUpError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (state is SignUpSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green,
                        ));
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                          context,
                          const SignInScreen(),
                        );
                      }
                    }, builder: (context, state) {
                      return MyCustomButton(
                        width: double.infinity,
                        height: 50.h,
                        function: state is SignUpLoading
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  user.password = _passwordController.text;
                                  user.passwordConfirm =
                                      _confirmPasswordController.text;
                                  context
                                      .read<SignUpBloc>()
                                      .add(SignUpButtonPressed(user: user));
                                }
                              },
                        buttonColor: primaryColorLight,
                        text: 'Créer compte',
                        circularRadious: 15.sp,
                        textButtonColor: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w800,
                        widget: state is SignUpLoading
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
