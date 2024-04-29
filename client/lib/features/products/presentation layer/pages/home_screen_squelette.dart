import 'package:client/core/colors.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/bottom_navigation_bar_screens.dart';
import '../bloc/bnv cubit/bnv_cubit.dart';
import '../widgets/ruesable_bottom_navigation_bar.dart';

class HomeScreenSquelette extends StatelessWidget {
  const HomeScreenSquelette({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {},
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
                    title: ReusableText(
                        text: PagesNames[state.currentIndex],
                        textSize: 18.sp,
                        textColor: Colors.white,
                        textFontWeight: FontWeight.w700),
                    centerTitle: true,
                    backgroundColor: primaryColor,
                    floating: true,
                    snap: true,
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
                  childCount: 1, // You can change this as per your requirement
                ),
              ),
            ],
          )),
    );
  }
}
