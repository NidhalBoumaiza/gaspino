import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:client/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bnv cubit/bnv_cubit.dart';

class ReusableBottomNavigationBar extends StatelessWidget {
  ReusableBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BnvCubit, BnvState>(
      builder: (context, state) {
        return AnimatedBottomNavigationBar.builder(
          backgroundColor: primaryColor,
          shadow: BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
          ),
          itemCount: 4,
          tabBuilder: (int index, bool isActive) {
            return Icon(iconList[index],
                size: 30,
                color: isActive ? Colors.white : Colors.grey.shade800);
          },
          activeIndex: state.currentIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          onTap: (index) {
            context.read<BnvCubit>().changeIndex(index);
          },

          //other params
        );
      },
    );
  }
}

final List<IconData> iconList = [
  Icons.home,
  Icons.search,
  Icons.notifications,
  Icons.person,
];
