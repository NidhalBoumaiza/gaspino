import 'package:client/features/products/presentation%20layer/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain layer/entities/product.dart';

class ProductHorizontalScreenWidget extends StatelessWidget {
  List<Product> products;

  ProductHorizontalScreenWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 0.88.h,

        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        //mainAxisExtent: 200,
      ),
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: ProductWidget(product: products[index]),
        );
      },
    );
  }
}
