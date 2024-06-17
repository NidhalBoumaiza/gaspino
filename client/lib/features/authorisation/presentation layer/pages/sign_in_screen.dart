import 'package:client/features/authorisation/presentation%20layer/cubit/password_visibility_sign_in_cubit/password_visibility_cubit.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/forget_password_screen.dart';
import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/my_customed_button.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../../core/widgets/reusable_text_field_widget.dart';
import '../bloc/sign_in_bloc/sign_in_bloc.dart';
import 'active_location_screen.dart';
import 'creation account/account_creation_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70.h),
                    ReusableText(
                      text: 'Bonjour',
                      textSize: 30.sp,
                      textFontWeight: FontWeight.w800,
                      textColor: const Color(0xff040003),
                    ),
                    SizedBox(height: 90.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ReusableTextFieldWidget(
                            keyboardType: TextInputType.emailAddress,
                            errorMessage: "Vous devez entrer votre email",
                            controller: _emailController,
                            hintText: "example@gmail.com",
                          ),
                          BlocBuilder<PasswordVisibilityCubit,
                              PasswordVisibilityState>(
                            builder: (context, state) {
                              print('state.isVisible: ${state.isVisible}');
                              return ReusableTextFieldWidget(
                                errorMessage:
                                    "Vous devez entrer votre mot de passe",
                                obsecureText: !state.isVisible,
                                controller: _passwordController,
                                hintText: "mot de passe",
                                onPressedSuffixIcon: () {
                                  context
                                      .read<PasswordVisibilityCubit>()
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
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            // Get.toNamed(
                            //   '/forgetPasswordScreen',
                            // );
                            navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                context, const ForgetPasswordScreen());
                          },
                          child: ReusableText(
                            text: "Mot de passe oublié ?",
                            textSize: 12.sp,
                            textColor: Colors.grey[600],
                            textFontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    BlocConsumer<SignInBloc, SignInState>(
                        listener: (context, state) {
                      if (state is SignInSuccess) {
                        navigateToAnotherScreenWithFadeTransition(
                          context,
                          ActiveLocationScreen(),
                        );
                      } else if (state is SignInError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }, builder: (context, state) {
                      return MyCustomButton(
                        width: double.infinity,
                        height: 50.h,
                        function: state is SignInLoading
                            ? () {}
                            : () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignInBloc>().add(
                                      SignInWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text));
                                }
                              },
                        buttonColor: primaryColorLight,
                        text: 'Se connecter',
                        circularRadious: 15.sp,
                        textButtonColor: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w800,
                        widget: state is SignInLoading
                            ? ReusablecircularProgressIndicator(
                                indicatorColor: Colors.white,
                              )
                            : const SizedBox(),
                      );
                    }),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(
                          text: "Nouveau chez nous ?",
                          textSize: 15.sp,
                          textColor: Colors.grey[600],
                          textFontWeight: FontWeight.w800,
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                context, const AccountCreationScreen());
                          },
                          child: ReusableText(
                            text: "S'inscrire",
                            textSize: 15.sp,
                            textColor: primaryColorLight,
                            textFontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
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

circularProgressIndicator() {
  return SizedBox(
    width: 12.w,
    height: 12.h,
    child: CircularProgressIndicator(
      color: Colors.black,
    ),
  );
}
