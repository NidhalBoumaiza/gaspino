import 'package:client/core/colors.dart';
import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../domain layer/entities/product.dart';

class ProductWidget extends StatelessWidget {
  Product product;

  ProductWidget({super.key, required this.product});

  DateFormat dateFormat = DateFormat('EEEE d MMMM', 'fr_FR');

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.0.w, 0.0.h, 5.0.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0.w, 5.0.h, 0.0.w, 0),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color(0xffe0eee9),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "${dotenv.env["URLIMAGE"]}${product.productPictures[0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.0.w, 2.0.h, 0.0.w, 0),
              child: ReusableText(
                text: product.name,
                textSize: 12.sp,
                textColor: Colors.black,
                textFontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                product.priceBeforeReduction != null
                    ? Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(5.0.w, 0.0.h, 0.0.w, 0),
                            child: ReusableText(
                              text: product.priceBeforeReduction.toString() +
                                  " DT",
                              textSize: 9.sp,
                              textColor: Colors.red,
                              textFontWeight: FontWeight.w600,
                              textDecoration: TextDecoration.lineThrough,
                              lineThickness: 3.h,
                            ),
                          ),
                          ReusableText(text: "/", textSize: 12.sp),
                        ],
                      )
                    : SizedBox(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0.w, 0.0.h, 0.0.w, 0),
                  child: ReusableText(
                    text: product.priceAfterReduction.toString() + " DT",
                    textSize: 10.sp,
                    textColor: Colors.green,
                    textFontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.0.w, 2.0.h, 0.0.w, 0),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.hourglassHalf,
                    color: primaryColor,
                    size: 15.sp,
                  ),
                  SizedBox(width: 5.w),
                  ReusableText(
                    text: dateFormat.format(product.expirationDate),
                    textSize: 10.sp,
                    textColor: Colors.black,
                    textFontWeight: FontWeight.w800,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
