import 'package:client/core/colors.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/commande/presentation%20layer/bloc/passer%20commande%20bloc/passer_commande_bloc.dart';
import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/svg.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../commande/presentation layer/cubit/shopping card cubit/shopping_card_cubit.dart';
import '../../widgets/shopping card widgets/ordred_product_widget.dart';

class MyShoppingCardScreen extends StatelessWidget {
  const MyShoppingCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCardCubit, ShoppingCardState>(
      builder: (context, state) {
        if (state.ordredProducts.isEmpty) {
          return Column(
            children: [
              SizedBox(height: 70.h),
              SizedBox(
                  height: 300.h,
                  child: Image.asset(
                    "assets/Grocery.png",
                    fit: BoxFit.cover,
                  )),
              SizedBox(height: 0.h),
              ReusableText(
                text: "Commander des Produits 😄",
                textSize: 18.sp,
                textFontWeight: FontWeight.w800,
                textColor: primaryColor,
              ),
            ],
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.ordredProducts.length,
                  itemBuilder: (context, index) {
                    final product = state.ordredProducts[index];
                    return Column(
                      children: [
                        OrderedProductWidget(product: product),
                      ],
                    );
                  },
                ),
                DashedLine(),
                SizedBox(height: 10.h),
                // TOTAL PRICE
                Row(
                  children: [
                    ReusableText(
                      text: "Total",
                      textSize: 15.sp,
                      textFontWeight: FontWeight.w800,
                      textColor: primaryColor,
                    ),
                    const Spacer(),
                    ReusableText(
                      text: "${state.totalPrice} DT",
                      textSize: 15.sp,
                      textFontWeight: FontWeight.w800,
                      textColor: primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                BlocConsumer<PasserCommandeBloc, PasserCommandeState>(
                  listener: (context, state) {
                    if (state is PasserCommandeSuccess) {
                      context.read<ShoppingCardCubit>().clearShoppingCard();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (state is PasserCommandeError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final shoppingCardState =
                        context.read<ShoppingCardCubit>().state;
                    return MyCustomButton(
                      widget: state is PasserCommandeLoading
                          ? ReusablecircularProgressIndicator(
                              indicatorColor: Colors.white,
                              height: 10.h,
                              width: 10.h,
                            )
                          : null,
                      width: SizeScreen.width,
                      height: 50.h,
                      function: () {
                        var products =
                            shoppingCardState.ordredProducts.map((product) {
                          return {
                            'productId': product.product.id,
                            'quantity': product.quantity
                          };
                        }).toList();

                        if (shoppingCardState.ordredProducts.isNotEmpty) {
                          context
                              .read<PasserCommandeBloc>()
                              .add(PasserCommande(products: products));
                        }
                      },
                      buttonColor: primaryColor,
                      text: "Passer la commande",
                      circularRadious: 15.sp,
                      textButtonColor: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    );
                  },
                ),

                // END
                SizedBox(height: 30.h),
              ],
            ),
          );
        }
      },
    );
  }
}

class DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 1),
      painter: DashedLinePainter(),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    double dashWidth = 5;
    double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
