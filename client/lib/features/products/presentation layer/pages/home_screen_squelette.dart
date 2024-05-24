import 'package:client/core/colors.dart';
import 'package:client/core/widgets/my_customed_button.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/core/widgets/reusable_text_field_widget.dart';
import 'package:client/features/products/presentation%20layer/bloc/get%20all%20products%20within%20distance%20bloc/get_all_products_within_distance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/bottom_navigation_bar_screens.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../cubit/bnv cubit/bnv_cubit.dart';
import '../cubit/slider cubit/slider_cubit.dart';
import '../widgets/ruesable_bottom_navigation_bar.dart';
import 'bottom navigation bar screens/add_product_screen.dart';

class HomeScreenSquelette extends StatelessWidget {
  const HomeScreenSquelette({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                navigateToAnotherScreenWithBottomToTopTransition(
                    context, AddProductScreen());
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // Change this with your desired roundness
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: ReusableBottomNavigationBar(),
            body: CustomScrollView(
              slivers: <Widget>[
                BlocBuilder<BnvCubit, BnvState>(
                  builder: (context, state) {
                    return SliverAppBar(
                      title: Padding(
                        padding: EdgeInsets.fromLTRB(0.w, 7.h, 0.w, 0.h),
                        child: ReusableText(
                          text: PagesNames[state.currentIndex],
                          textSize: 18.sp,
                          textColor: Colors.white,
                          textFontWeight: FontWeight.w700,
                        ),
                      ),
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: primaryColor,
                      floating: true,
                      snap: true,
                      bottom: state.currentIndex == 0
                          ? PreferredSize(
                              preferredSize: Size.fromHeight(50.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(5.w, 0.h, 0.w, 0.h),
                                    child: SizedBox(
                                      height: 60.h,
                                      width: 300.w,
                                      child: ReusableTextFieldWidget(
                                        controller: searchController,
                                        hintText: 'recherche',
                                        suffixIcon: Icon(
                                          Icons.search,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.sliders,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      showDistanceDialog(context);
                                      // context
                                      //     .read<GetProductsWithinDistanceBloc>()
                                      //     .add(GetProductsWithinDistance(
                                      //         distance: 100000000));
                                    },
                                  ),
                                ],
                              ),
                            )
                          : null,
                    );
                  },
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return BlocBuilder<BnvCubit, BnvState>(
                        builder: (context, state) {
                          return bottomNavigationBarScreens[state.currentIndex];
                        },
                      );
                    },
                    childCount:
                        1, // You can change this as per your requirement
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

void showDistanceDialog(BuildContext context) {
  TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: double.infinity,
        height: 230.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            ReusableText(
                text: "Distance de recherche",
                textSize: 17.sp,
                textColor: Colors.white,
                textFontWeight: FontWeight.w800),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SliderTheme(
                data: const SliderThemeData(
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 0.0, // Set the size of the overlay
                  ),

                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  // Set the value indicator shape
                  showValueIndicator: ShowValueIndicator.always,
                  // Show the value indicator
                  trackHeight: 1.5,
                  // rangeThumbShape: RangeSliderThumbShape(),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 8.0,
                    pressedElevation: 0,
                  ),
                  valueIndicatorTextStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                child: SliderTheme(
                  data: const SliderThemeData(
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 0.0, // Set the size of the overlay
                    ),

                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    // Set the value indicator shape
                    showValueIndicator: ShowValueIndicator.always,
                    // Show the value indicator
                    trackHeight: 1.5,
                    // rangeThumbShape: RangeSliderThumbShape(),
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 8.0,
                      pressedElevation: 0,
                    ),
                    valueIndicatorTextStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  child: BlocBuilder<SliderCubit, SliderState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Slider(
                            label: "${state.distance.floor().toString()} Km",
                            min: 2.0,
                            max: 20.0,
                            value: state.distance,
                            onChanged: (val) {
                              context.read<SliderCubit>().changeDistance(val);
                            },
                            thumbColor: Colors.white,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white,
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 100.w,
                            height: 60.h,
                            child: ReusableTextFieldWidget(
                              controller: controller
                                ..text =
                                    "${state.distance.floor().toString()} Km",
                              hintText: "Distance",
                              textAlignProperty: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          MyCustomButton(
                            width: 150.w,
                            height: 50.h,
                            function: () {
                              Navigator.pop(context);
                              BlocProvider.of<GetProductsWithinDistanceBloc>(
                                      context)
                                  .add(GetProductsWithinDistancee(
                                      distance: state.distance.floor()));
                            },
                            buttonColor: Colors.white,
                            text: "Recherche",
                            textButtonColor: primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
