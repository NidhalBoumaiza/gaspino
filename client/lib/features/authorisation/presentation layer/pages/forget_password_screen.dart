// ignore_for_file: prefer_const_constructors

import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/reset_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/strings.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/my_customed_button.dart';
import '../../../../core/widgets/reusable_text_field_widget.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../products/presentation layer/widgets/circularProgressiveIndicator.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController _emailController = TextEditingController();

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
                    text: "Mot de passe oublié",
                    textSize: 18.sp,
                    textFontWeight: FontWeight.w800,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 5.h),
                  ReusableText(
                    text:
                        "Veuillez entrer l'adresse e-mail associée à votre compte et nous vous enverrons un e-mail de confirmation pour réinitialiser votre mot de passe.",
                    textSize: 12.sp,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ReusableTextFieldWidget(
                        errorMessage: "Vous devez entrer votre email",
                        hintText: "Email",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0.h),
                    child:
                        BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                            listener: (context, state) {
                      if (state is ForgetPasswordError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (state is ForgetPasswordSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(ForgetPasswordSuccessMessage),
                          backgroundColor: Colors.green,
                        ));
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                          context,
                          ResetCodeScreen(email: _emailController.text),
                        );
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
                                  context.read<ForgetPasswordBloc>().add(
                                      ForgetPasswordRequest(
                                          email: _emailController.text));
                                }
                              },
                        buttonColor: primaryColorLight,
                        text: 'Envoyer le code',
                        circularRadious: 15.sp,
                        textButtonColor: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w800,
                        widget: state is ForgetPasswordLoading
                            ? ReusablecircularProgressIndicator(
                                indicatorColor: Colors.white,
                              )
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
