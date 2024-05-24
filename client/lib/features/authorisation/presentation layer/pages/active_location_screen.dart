import 'dart:async';

import 'package:client/core/colors.dart';
import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/sign_in_screen.dart';
import 'package:client/features/products/presentation%20layer/pages/home_screen_squelette.dart';
import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/svg.dart';
import '../../../../core/widgets/animation_fade_it_in.dart';
import '../../../../core/widgets/my_customed_button.dart';
import '../bloc/update_coordinate_bloc/update_coordinate_bloc.dart';

class ActiveLocationScreen extends StatefulWidget {
  const ActiveLocationScreen({Key? key}) : super(key: key);

  @override
  State<ActiveLocationScreen> createState() => _ActiveLocationScreenState();
}

class _ActiveLocationScreenState extends State<ActiveLocationScreen> {
  bool _showWidget1 = false;
  bool _showWidget2 = false;
  bool _showWidget3 = false;
  bool _showWidget4 = false;

  @override
  void initState() {
    super.initState();
    _showWidgetsOneByOne();
  }

  void _showWidgetsOneByOne() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _showWidget1 = true;
      });
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _showWidget2 = true;
      });
    });

    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _showWidget3 = true;
      });
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showWidget4 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            // extendBodyBehindAppBar: true,
            // appBar: arguments != null ? null : appBar,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Stack(
                      children: [
                        Image.asset('assets/maponly.jpg'),
                        Positioned(
                          left: 60.w,
                          top: 45.h,
                          child: Visibility(
                            visible: _showWidget1,
                            child: AnimationFindIn(
                              child: Image.asset('assets/1.jpg'),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 165.w,
                          top: 55.h,
                          child: Visibility(
                            visible: _showWidget2,
                            child: AnimationFindIn(
                              child: Image.asset('assets/2.jpg'),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60.w,
                          top: 130.h,
                          child: Visibility(
                            visible: _showWidget3,
                            child: AnimationFindIn(
                              child: Image.asset('assets/3.jpg'),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 165.w,
                          top: 130.h,
                          child: Visibility(
                            visible: _showWidget4,
                            child: AnimationFindIn(
                              child: Image.asset('assets/4.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ReusableText(
                        text: "Activer la localisation",
                        textSize: 20.sp,
                        textFontWeight: FontWeight.w800,
                        textColor: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: ReusableText(
                        text:
                            "Permettre à l'application d'accéder à votre emplacement? Vous devez autoriser l'accès pour que l'application fonctionne. Nous ne suivrons votre emplacement que pendant le service.",
                        textSize: 13.sp,
                        textFontWeight: FontWeight.w600,
                        textColor: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: SizeScreen.height * 0.147),
                    BlocConsumer<UpdateCoordinateBloc, UpdateCoordinateState>(
                        listener: (context, state) {
                      if (state is UpdateCoordinateSuccess) {
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                            context, HomeScreenSquelette());
                      } else if (state is UpdateCoordinateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is UpdateCoordinateUnauthorized) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                        navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                            context, SignInScreen());
                      }
                    }, builder: (context, state) {
                      return MyCustomButton(
                        width: double.infinity,
                        height: 50.h,
                        function: state is UpdateCoordinateLoading
                            ? () {}
                            : () {
                                context
                                    .read<UpdateCoordinateBloc>()
                                    .add(UpdateCoordinate());
                              },
                        buttonColor: primaryColorLight,
                        text: 'Activer localisation',
                        circularRadious: 15.sp,
                        textButtonColor: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w800,
                        widget: state is UpdateCoordinateLoading
                            ? ReusablecircularProgressIndicator(
                                indicatorColor: Colors.white,
                              )
                            : null,
                      );
                    }),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
