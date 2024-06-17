import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account/picture_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../../../../core/widgets/reusable_text_field_widget.dart';
import '../../../../../core/widgets/simple_app_bar.dart';
import '../../../domain layer/entities/user.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late User newUser;

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
              height: 1.2.sh,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80.h),
                    ReusableText(
                      text: 'Données personnelles',
                      textSize: 20.sp,
                      textFontWeight: FontWeight.w800,
                      textColor: primaryTextColor,
                    ),
                    SizedBox(height: 5.h),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 108.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          text: 'Prénom',
                                          textSize: 12.sp,
                                          textFontWeight: FontWeight.w500,
                                          textColor: primaryTextColor,
                                        ),
                                        ReusableTextFieldWidget(
                                          errorMessage: "Saisir votre prénom",
                                          controller: _prenomController,
                                          hintText: "Flen",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          text: 'Nom',
                                          textSize: 12.sp,
                                          textFontWeight: FontWeight.w500,
                                          textColor: primaryTextColor,
                                        ),
                                        ReusableTextFieldWidget(
                                          errorMessage: "Saisir votre nom",
                                          controller: _nomController,
                                          hintText: "Ben foulen",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: 'Contact',
                                  textSize: 20.sp,
                                  textFontWeight: FontWeight.w800,
                                  textColor: primaryTextColor,
                                ),
                                SizedBox(height: 5.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                      text: 'Email',
                                      textSize: 12.sp,
                                      textFontWeight: FontWeight.w500,
                                      textColor: primaryTextColor,
                                    ),
                                    ReusableTextFieldWidget(
                                      errorMessage: "Saisir votre email",
                                      controller: _emailController,
                                      hintText: "Example@gmail.com",
                                      keyboardType: TextInputType.emailAddress,
                                      validatorFunction: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Saisir votre email';
                                        }
                                        // Regular expression for validating an email
                                        String pattern =
                                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                        RegExp regex = RegExp(pattern);
                                        if (!regex.hasMatch(value)) {
                                          return 'Entrez une adresse e-mail valide';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                      text: 'Téléphone',
                                      textSize: 12.sp,
                                      textFontWeight: FontWeight.w500,
                                      textColor: primaryTextColor,
                                    ),
                                    ReusableTextFieldWidget(
                                      keyboardType: TextInputType.phone,
                                      errorMessage: "Saisir votre téléphone",
                                      controller: _phoneController,
                                      hintText: "+216 99 999 999",
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40.h),
                                MyCustomButton(
                                  width: double.infinity,
                                  height: 50.h,
                                  function: () {
                                    if (_formKey.currentState!.validate()) {
                                      newUser = User.create(
                                        firstName: _prenomController.text,
                                        lastName: _nomController.text,
                                        phoneNumber: _phoneController.text,
                                        email: _emailController.text,
                                        password: '',
                                        passwordConfirm: '',
                                      );
                                      navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                                          context,
                                          PictureCreationScreen(
                                            user: newUser,
                                          ));
                                    }
                                  },
                                  buttonColor: primaryColorLight,
                                  text: 'Suivant',
                                  circularRadious: 15.sp,
                                  textButtonColor: Colors.white,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w800,
                                  widget: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
