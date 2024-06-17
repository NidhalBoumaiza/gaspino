// ignore_for_file: prefer_const_constructors

import 'package:client/features/authorisation/presentation%20layer/pages/creation%20account/password_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/utils/image picker/image_picker_functions.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../../../../core/widgets/simple_app_bar.dart';
import '../../../domain layer/entities/user.dart';
import '../../cubit/profile_pic_creation _cubit/profile_pic_creation__cubit.dart';

class PictureCreationScreen extends StatelessWidget {
  late User user ;
  PictureCreationScreen({super.key , required  this.user});

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
                      text: "Photo de profil",
                      textSize: 18.sp,
                      textFontWeight: FontWeight.w800,
                      textColor: Colors.black,
                    ),
                    SizedBox(height: 5.h),
                    ReusableText(
                      text:
                          "Ajouter une photo de profil pour que les autres utilisateurs puissent vous reconnaître. (Optionnel)",
                      textSize: 12.sp,
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: BlocBuilder<ProfilePicCreationCubit,
                          ProfilePicCreationState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              showImagePicker(context);
                            },
                            child: Stack(
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Ink.image(
                                      image: state.img != null
                                          ? MemoryImage(state.img)
                                          : const AssetImage(
                                                  "assets/user.jpg")
                                              as ImageProvider<Object>,
                                      fit: BoxFit.cover,
                                      width: 250,
                                      height: 250,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 20.w,
                                  bottom: 20.h,
                                  child: buildEditIcon(Colors.white),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 60.h),
                    MyCustomButton(
                      width: double.infinity,
                      height: 50.h,
                      function: () {
                          user.profilePicture = context.read<ProfilePicCreationCubit>().state.croppedImage ?? "";
                          navigateToAnotherScreenWithSlideTransitionFromRightToLeft(context, PasswordCreationScreen(user: user));
                      },
                      buttonColor: primaryColorLight,
                      text: 'Suivant',
                      circularRadious: 15.sp,
                      textButtonColor: Colors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w800,
                      widget: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
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


Widget buildEditIcon(Color color) => buildCircle(
  color: Colors.white,
  all: 3,
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      // onTap: onClicked,
      child: buildCircle(
        color: color,
        all: 3,
        child: const Icon(
          Icons.add_a_photo,
          color: Color(0xff284F7B),
          size: 18,
        ),
      ),
    ),
  ),
);

Widget buildCircle(
{required Widget child,
required double all,
required Color color,
required}) =>
ClipOval(
child: Material(
child: Container(
padding: EdgeInsets.all(all),
color: color,
child: child,
),
),
);
