// ignore_for_file: avoid_unnecessary_containers

import 'package:client/core/colors.dart';
import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/sign_in_screen.dart';
import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../bloc/get all products within distance bloc expires today/get_products_expires_today_bloc.dart';
import '../../bloc/get all products within distance bloc/get_all_products_within_distance_bloc.dart';
import '../../shimmers/home_page_H_shimmer.dart';
import '../../shimmers/home_page_v_shimmer.dart';
import '../../widgets/product_grid_view_widget.dart';
import '../../widgets/product_horizontal_screen_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<GetProductsWithinDistanceBloc>(context)
        .add(GetProductsWithinDistancee(distance: 10000000000000000));
    BlocProvider.of<GetProductsExpiresTodayBloc>(context)
        .add(GetProductsWithinDistanceee(distance: 10000000000000000));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<GetProductsExpiresTodayBloc,
                GetProductsExpiresTodayState>(builder: (context, state) {
              if (state is GetProductsExpiresTodayLoading) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ReusableText(
                            text: "Ces produits expirent aujourd'hui",
                            textSize: 14.sp,
                            textFontWeight: FontWeight.w800,
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            FontAwesomeIcons.clock,
                            color: primaryColor,
                            size: 15.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      const HomePageHShimmer(),
                    ],
                  ),
                );
                // return Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       height: MediaQuery.of(context).size.height * 0.1,
                //     ),
                //     Center(
                //       child: ReusablecircularProgressIndicator(
                //         height: 20.h,
                //         width: 20.w,
                //         indicatorColor: primaryColor,
                //       ),
                //     ),
                //   ],
                // );
              } else if (state is GetProductsExpiresTodayLoaded) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ReusableText(
                            text: "Ces produits expirent aujourd'hui",
                            textSize: 14.sp,
                            textFontWeight: FontWeight.w800,
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            FontAwesomeIcons.clock,
                            color: primaryColor,
                            size: 15.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                          width: double.infinity,
                          height: 170.h,
                          child: ProductHorizontalScreenWidget(
                            products: state.products,
                          )),
                    ],
                  ),
                );
              } else if (state is GetProductsExpiresTodayError) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ReusableText(
                            text: "Ces produits expirent aujourd'hui",
                            textSize: 14.sp,
                            textFontWeight: FontWeight.w800,
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            FontAwesomeIcons.clock,
                            color: primaryColor,
                            size: 15.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Center(
                        child: Image.asset(
                          "assets/bag-removebg.jpg",
                          height: 100.h,
                          width: 100.w,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Center(
                        child: ReusableText(
                          text: "Aucun produit expirera aujourd'hui",
                          textSize: 13.sp,
                          textFontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is GetProductsExpiresTodayUnauthorized) {
                BlocProvider.of<SignOutBloc>(context)
                    .add(SignOutMyAccountEventPressed());
                return BlocConsumer<SignOutBloc, SignOutState>(
                    builder: (context, state) {
                  if (state is SignOutLoading) {
                    return ReusablecircularProgressIndicator(
                      height: 20.h,
                      width: 20.w,
                      indicatorColor: primaryColor,
                    );
                  } else {
                    return const Text("errrorororororor");
                  }
                }, listener: (context, state) {
                  if (state is SignOutSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Votre session a expiré , veuillez vous reconnecter"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                      context,
                      SignInScreen(),
                    );
                  } else if (state is SignOutError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });
              } else {
                return const Text("errrorororororor");
              }
            }),
            BlocBuilder<GetProductsWithinDistanceBloc,
                GetProductsWithinDistanceState>(
              builder: (context, state) {
                if (state is GetProductsWithinDistanceLoading) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 15.h, 5.w, 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "Autres produits :",
                          textSize: 14.sp,
                          textFontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 5.h),
                        const SizedBox(
                          width: double.infinity,
                          // height: MediaQuery.of(context).size.height,
                          child: HomePageVShimmer(),
                        ),
                      ],
                    ),
                  );
                } else if (state is GetProductsWithinDistanceLoaded) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 15.h, 5.w, 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "Autes produit :",
                          textSize: 14.sp,
                          textFontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 5.h),
                        SizedBox(
                          width: double.infinity,
                          // height: MediaQuery.of(context).size.height,
                          child: GestureDetector(
                            child: ProductGridViewWidget(
                              onRefresh: () => _onRefresh(context),
                              products: state.products,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is GetProductsWithinDistanceError) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 30.h, 5.w, 0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "Autres produit :",
                          textSize: 14.sp,
                          textFontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 50.h),
                        Center(
                          child: Image.asset(
                            "assets/bag-removebg.jpg",
                            height: 100.h,
                            width: 100.w,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Center(
                          child: ReusableText(
                            text:
                                "Aucun produit n'est disponible\ndans votre zone",
                            textSize: 13.sp,
                            textFontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is GetProductsWithinDistanceUnauthorized) {
                  BlocProvider.of<SignOutBloc>(context)
                      .add(SignOutMyAccountEventPressed());
                  return BlocConsumer<SignOutBloc, SignOutState>(
                      builder: (context, state) {
                    if (state is SignOutLoading) {
                      return ReusablecircularProgressIndicator(
                        height: 20.h,
                        width: 20.w,
                        indicatorColor: primaryColor,
                      );
                    } else {
                      return const Text("errrorororororor");
                    }
                  }, listener: (context, state) {
                    if (state is SignOutSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Votre session a expiré , veuillez vous reconnecter"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                        context,
                        SignInScreen(),
                      );
                    } else if (state is SignOutError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.38,
                      ),
                      Center(
                        child: ReusablecircularProgressIndicator(
                          height: 20.h,
                          width: 20.w,
                          indicatorColor: primaryColor,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<GetProductsWithinDistanceBloc>(context)
      .add(RefreshGetProductsWithinDistancee(distance: 100000000));
}
