import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../commande/domain layer/entities/ordred_product.dart';
import '../../../../commande/presentation layer/cubit/shopping card cubit/shopping_card_cubit.dart';
import '../../cubit/product quantity cubit/product_quantity_cubit.dart';
import '../../pages/details_product_screen.dart';

class OrderedProductWidget extends StatelessWidget {
  final OrderedProduct product;

  OrderedProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productQuantityCubit = context.read<ProductQuantityCubit>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  navigateToAnotherScreenWithFadeTransition(
                      context, DetailsProductScreen(product: product.product));
                },
                child: Row(
                  children: [
                    Container(
                      height: 60.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "${dotenv.env["URLIMAGE"]}${product.product.productPictures[0]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: product.product.name,
                          textSize: 13.sp,
                          textFontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            product.product.priceBeforeReduction != null
                                ? Row(
                                    children: [
                                      ReusableText(
                                        text: product
                                                .product.priceBeforeReduction
                                                .toString() +
                                            " DT",
                                        textSize: 11.sp,
                                        textColor: Colors.red,
                                        textFontWeight: FontWeight.w400,
                                        textDecoration:
                                            TextDecoration.lineThrough,
                                        lineThickness: 3.h,
                                      ),
                                      ReusableText(
                                          text: " / ", textSize: 11.sp),
                                    ],
                                  )
                                : SizedBox(),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.0.w, 0.0.h, 0.0.w, 0),
                              child: ReusableText(
                                text:
                                    "${product.product.priceAfterReduction} DT",
                                textSize: 11.sp,
                                textColor: Colors.green,
                                textFontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 15.0.h, right: 10.0.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          // Decrease the quantity of the product
                          final currentQuantity = productQuantityCubit
                                  .state.quantities[product.product.id] ??
                              1;
                          if (currentQuantity > 1) {
                            productQuantityCubit.changeQuantity(
                                product.product.id, currentQuantity - 1);
                            final quantity = productQuantityCubit
                                    .state.quantities[product.product.id] ??
                                1;
                            final productToAdd = OrderedProduct(
                                product.product, quantity, "pending");
                            context
                                .read<ShoppingCardCubit>()
                                .addProduct(productToAdd);
                          }
                        },
                        icon: Icon(FontAwesomeIcons.circleMinus,
                            color: Colors.grey.shade400, size: 30.sp)),
                    // Display the current quantity of the product
                    BlocBuilder<ProductQuantityCubit, ProductQuantityState>(
                      builder: (context, state) {
                        final quantity =
                            state.quantities[product.product.id] ?? 1;
                        return ReusableText(text: "$quantity", textSize: 15.sp);
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          // Increase the quantity of the product
                          final currentQuantity = productQuantityCubit
                                  .state.quantities[product.product.id] ??
                              1;
                          if (currentQuantity < product.product.quantity) {
                            productQuantityCubit.changeQuantity(
                                product.product.id, currentQuantity + 1);
                            final quantity = productQuantityCubit
                                    .state.quantities[product.product.id] ??
                                1;
                            final productToAdd = OrderedProduct(
                                product.product, quantity, "pending");
                            context
                                .read<ShoppingCardCubit>()
                                .addProduct(productToAdd);
                          }
                        },
                        icon: Icon(FontAwesomeIcons.circlePlus,
                            color: primaryColor, size: 30.sp)),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: -10.w,
            top: -9.h,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.circleXmark, color: Colors.red),
              onPressed: () {
                // Remove the product from the ordered list
                context.read<ShoppingCardCubit>().removeProduct(product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
