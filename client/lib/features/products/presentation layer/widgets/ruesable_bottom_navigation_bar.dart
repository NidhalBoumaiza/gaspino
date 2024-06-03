import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:client/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../commande/presentation layer/cubit/shopping card cubit/shopping_card_cubit.dart';
import '../cubit/bnv cubit/bnv_cubit.dart';

class ReusableBottomNavigationBar extends StatelessWidget {
  ReusableBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BnvCubit, BnvState>(
      builder: (context, state) {
        return AnimatedBottomNavigationBar.builder(
          backgroundColor: Colors.white,
          shadow: BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
          ),
          itemCount: 4,
          tabBuilder: (int index, bool isActive) {
            return index != 2
                ? Icon(
                    iconList[index],
                    size: index == 1 ? 25 : 30,
                    color: isActive ? primaryColor : Colors.grey.shade600,
                  )
                : Center(
                    child: Stack(
                      children: [
                        Icon(
                          iconList[index],
                          size: 30,
                          color: isActive ? primaryColor : Colors.grey.shade600,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: BlocBuilder<ShoppingCardCubit,
                                ShoppingCardState>(
                              builder: (context, state) {
                                return Text(
                                  state.totalQuantity.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
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
  FontAwesomeIcons.store,
  Icons.shopping_cart,
  Icons.person,
];
