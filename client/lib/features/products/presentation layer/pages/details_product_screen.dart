import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/products/domain%20layer/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/colors.dart';
import '../cubit/product quantity cubit/product_quantity_cubit.dart';

class DetailsProductScreen extends StatelessWidget {
  Product product;

  DetailsProductScreen({super.key, required this.product});

  DateFormat dateFormat = DateFormat('EEEE d MMMM', 'fr_FR');

  @override
  Widget build(BuildContext context) {
    final productQuantityCubit = context.read<ProductQuantityCubit>();

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow
          leading: SizedBox(
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.circleArrowLeft,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: const Color(0xffe0eee9),
                image: DecorationImage(
                  image: NetworkImage(
                      "${dotenv.env["URLIMAGE"]}${product.productPictures[0]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: product.name,
                    textSize: 20.sp,
                    textFontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Prix",
                            textSize: 15.sp,
                            textFontWeight: FontWeight.w800,
                          ),
                          Row(
                            children: [
                              product.priceBeforeReduction != null
                                  ? Row(
                                      children: [
                                        ReusableText(
                                          text: product.priceBeforeReduction
                                                  .toString() +
                                              " DT",
                                          textSize: 14.sp,
                                          textColor: Colors.red,
                                          textFontWeight: FontWeight.w400,
                                          textDecoration:
                                              TextDecoration.lineThrough,
                                          lineThickness: 3.h,
                                        ),
                                        ReusableText(
                                            text: " / ", textSize: 12.sp),
                                      ],
                                    )
                                  : SizedBox(),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0.w, 0.0.h, 0.0.w, 0),
                                child: ReusableText(
                                  text: "${product.priceAfterReduction} DT",
                                  textSize: 14.sp,
                                  textColor: Colors.green,
                                  textFontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                // Decrease the quantity of the product
                                final currentQuantity = productQuantityCubit
                                        .state.quantities[product.id] ??
                                    1;
                                if (currentQuantity > 1) {
                                  productQuantityCubit.changeQuantity(
                                      product.id, currentQuantity - 1);
                                }
                              },
                              icon: Icon(FontAwesomeIcons.circleMinus,
                                  color: Colors.grey.shade400, size: 30.sp)),
                          // Display the current quantity of the product
                          BlocBuilder<ProductQuantityCubit,
                              ProductQuantityState>(
                            builder: (context, state) {
                              final quantity =
                                  state.quantities[product.id] ?? 1;
                              return ReusableText(
                                  text: "$quantity", textSize: 15.sp);
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                // Increase the quantity of the product
                                final currentQuantity = productQuantityCubit
                                        .state.quantities[product.id] ??
                                    1;
                                productQuantityCubit.changeQuantity(
                                    product.id, currentQuantity + 1);
                              },
                              icon: Icon(FontAwesomeIcons.circlePlus,
                                  color: primaryColor, size: 30.sp)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ReusableText(
                    text: "Quantité",
                    textSize: 15.sp,
                    textFontWeight: FontWeight.w800,
                  ),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.cartShopping,
                          color: Colors.black, size: 15.sp),
                      SizedBox(width: 10.w),
                      ReusableText(
                        text: product.quantity.toString(),
                        textSize: 15.sp,
                        textFontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ReusableText(
                      text: "Date d'expiration",
                      textSize: 15.sp,
                      textFontWeight: FontWeight.w800),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.hourglassHalf,
                        color: primaryColor,
                        size: 15.sp,
                      ),
                      SizedBox(width: 5.w),
                      ReusableText(
                        text: dateFormat.format(product.expirationDate),
                        textSize: 14.sp,
                        textColor: Colors.black,
                        textFontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  product.description != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Description",
                              textSize: 15.sp,
                              textFontWeight: FontWeight.w800,
                            ),
                            ReusableText(
                              text: product.description!,
                              textSize: 14.sp,
                              textFontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 10.h),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
