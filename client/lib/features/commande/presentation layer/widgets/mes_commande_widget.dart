import 'package:client/core/colors.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/commande/presentation%20layer/widgets/status_identifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain layer/entities/ordred_product.dart';

class MesCommandeWidget extends StatelessWidget {
  OrderedProduct product;

  MesCommandeWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print(product.quantity);
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
                      image: product.product.productPictures[0] == null
                          ? const AssetImage("assets/Eating.png")
                              as ImageProvider<Object>
                          : NetworkImage(
                              "${dotenv.env["URLIMAGE"]}${product.product.productPictures[0]}"),
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
                      text: product.product.name,
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
                          text: product.quantity.toString(),
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
                          text: product.product.productOwner!.firstName +
                              " " +
                              product.product.productOwner!.lastName,
                          textSize: 13.sp,
                          textFontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(
                            'tel://${product.product!.productOwner.phoneNumber}'));
                      },
                      child: ReusableText(
                        text: product.product!.productOwner.phoneNumber,
                        textSize: 13.sp,
                        textFontWeight: FontWeight.w700,
                        textColor: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120.h,
                child: const VerticalDivider(
                  thickness: 2,
                  color: primaryColor,
                  endIndent: 5,
                  indent: 5,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 15.h),
                  ReusableText(
                    text:
                        product.product.priceAfterReduction.toString() + " Dt",
                    textSize: 13.sp,
                    textFontWeight: FontWeight.w800,
                    textColor: primaryColor,
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 92.w,
                    child: ReusableText(
                      text: dateFormatForRecoveryDate
                          .format(product.product.createdAt!),
                      textSize: 13.sp,
                      textFontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  product.orderedProductStatus == "delivered"
                      ? StatusIdentifier(
                          borderColor: const Color(0xffEAEBEC),
                          mainColor: const Color(0xffF6FFED),
                          tectColor: const Color(0xff389E0D),
                          textContent: 'deliveré',
                        )
                      : product.orderedProductStatus == "refused"
                          ? StatusIdentifier(
                              borderColor: const Color(0xffEAEBEC),
                              mainColor: const Color(0xffFFF1F0),
                              tectColor: const Color(0xffCF1322),
                              textContent: 'Rejeté',
                            )
                          : product.orderedProductStatus == "cancelled"
                              ? StatusIdentifier(
                                  borderColor: const Color(0xffEAEBEC),
                                  mainColor: const Color(0xffFFF1F0),
                                  tectColor: const Color(0xffCF1322),
                                  textContent: 'Annuler',
                                )
                              : StatusIdentifier(
                                  borderColor: const Color(0xffEAEBEC),
                                  mainColor: const Color(0xffFFF7E6),
                                  tectColor: const Color(0xffDC6B08),
                                  textContent: 'En attente',
                                )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
