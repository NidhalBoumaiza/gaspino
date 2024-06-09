import 'package:client/features/products/presentation%20layer/cubit/new%20password%20cubit/new_password_cubit.dart';
import 'package:client/features/products/presentation%20layer/cubit/old%20password%20cubit/old_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/strings.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../../../../core/widgets/reusable_text_field_widget.dart';
import '../../../../authorisation/presentation layer/bloc/update_user_password_bloc/update_user_password_bloc.dart';
import '../../cubit/confirm new password cubit/confirm_new_password_cubit.dart';
import '../../widgets/circularProgressiveIndicator.dart';

class ModifyPasswordScreen extends StatelessWidget {
  ModifyPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmNewPasswordController =
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
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: ReusableText(
              text: 'Changer le mot de passe',
              textSize: 18.sp,
              textColor: Colors.white,
              textFontWeight: FontWeight.w800,
            ),
            backgroundColor: primaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  ReusableText(
                    text: "Changer mot de passe",
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BlocBuilder<OldPasswordCubit, OldPasswordState>(
                          builder: (context, state) {
                            return ReusableTextFieldWidget(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2),
                              errorMessage:
                                  "Vous devez entrer votre ancien un mot de passe",
                              obsecureText: !state.isVisible,
                              controller: _oldPasswordController,
                              hintText: "Ancien mot de passe",
                              onPressedSuffixIcon: () {
                                context
                                    .read<OldPasswordCubit>()
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
                        BlocBuilder<NewPasswordCubit, NewPasswordState>(
                          builder: (context, state) {
                            return ReusableTextFieldWidget(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2),
                              errorMessage:
                                  "Vous devez saisir votre nouveau mot de passe",
                              obsecureText: !state.isVisible,
                              controller: _newPasswordController,
                              hintText: "Nouveau mot de passe",
                              onPressedSuffixIcon: () {
                                context
                                    .read<NewPasswordCubit>()
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
                        BlocBuilder<ConfirmNewPasswordCubit,
                            ConfirmNewPasswordState>(
                          builder: (context, state) {
                            return ReusableTextFieldWidget(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2),
                              errorMessage:
                                  "Vous devez confirmer votre nouveau mot de passe",
                              obsecureText: !state.isVisible,
                              controller: _confirmNewPasswordController,
                              hintText: "Confirmer mot de passe",
                              onPressedSuffixIcon: () {
                                context
                                    .read<ConfirmNewPasswordCubit>()
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
                        SizedBox(height: 40.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0.h),
                          child: BlocConsumer<UpdateUserPasswordBloc,
                                  UpdateUserPasswordState>(
                              listener: (context, state) {
                            if (state is UpdateUserPasswordError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ));
                            }
                            if (state is UpdateUserPasswordSuccess) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(PasswordChangeSucessMessage),
                                backgroundColor: Colors.green,
                              ));
                            }
                          }, builder: (context, state) {
                            return MyCustomButton(
                              width: double.infinity,
                              height: 50.h,
                              function: state is UpdateUserPasswordLoading
                                  ? () {}
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<UpdateUserPasswordBloc>()
                                            .add(
                                              UpdateUserPasswordEventPasswordChanging(
                                                oldPassword:
                                                    _oldPasswordController.text,
                                                newPassword:
                                                    _newPasswordController.text,
                                                newPasswordConfirm:
                                                    _confirmNewPasswordController
                                                        .text,
                                              ),
                                            );
                                      }
                                    },
                              buttonColor: primaryColorLight,
                              text: 'Changer le mot de passe',
                              circularRadious: 15.sp,
                              textButtonColor: Colors.white,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w800,
                              widget: state is UpdateUserPasswordLoading
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
