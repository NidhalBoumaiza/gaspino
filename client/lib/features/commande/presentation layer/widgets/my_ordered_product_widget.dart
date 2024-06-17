import 'package:client/core/colors.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../domain layer/entities/commande.dart';

class MyOrderedProductWidget extends StatelessWidget {
  Commande commande;

  MyOrderedProductWidget({super.key, required this.commande});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatForRecoveryDate =
        DateFormat('EEEE d MMMM, HH:mm', 'fr_FR');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              1.0,
              1.0,
            ), // Offset in right and down directions
            blurRadius: 7.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5.w),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: commande.products[0].product.productPictures[0] ==
                              null
                          ? AssetImage("assets/Eating.png")
                              as ImageProvider<Object>
                          : NetworkImage(
                              "${dotenv.env["URLIMAGE"]}${commande.products[0].product.productPictures[0]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: commande.products[0].product.name,
                      textSize: 14.sp,
                      textFontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                          text:
                              commande.products[0].product.quantity.toString(),
                          textSize: 13.sp,
                          textFontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      child: Container(
                        width: 120.w,
                        child: ReusableText(
                          text: commande.commandeOwner!.firstName +
                              " " +
                              commande.commandeOwner!.lastName,
                          textSize: 13.sp,
                          textFontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ReusableText(
                      text: commande.commandeOwner!.phoneNumber,
                      textSize: 13.sp,
                      textFontWeight: FontWeight.w700,
                      textColor: primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120.h,
                child: VerticalDivider(
                  thickness: 2,
                  color: primaryColor,
                  endIndent: 5,
                  indent: 5,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 25.h),
                  ReusableText(
                    text: commande.products[0].product.priceAfterReduction
                            .toString() +
                        " Dt",
                    textSize: 13.sp,
                    textFontWeight: FontWeight.w800,
                    textColor: primaryColor,
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: 92.w,
                    child: ReusableText(
                      text:
                          dateFormatForRecoveryDate.format(commande.createdAt!),
                      textSize: 13.sp,
                      textFontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
