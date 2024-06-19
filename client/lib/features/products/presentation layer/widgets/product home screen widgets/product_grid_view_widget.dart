import 'package:client/core/utils/navigation_with_transition.dart';
import 'package:client/features/products/presentation%20layer/pages/details_product_screen.dart';
import 'package:client/features/products/presentation%20layer/widgets/product%20home%20screen%20widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain layer/entities/product.dart';

class ProductGridViewWidget extends StatelessWidget {
  List<Product> products;
  Future<void> Function()? onRefresh;

  ProductGridViewWidget({super.key, required this.products, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ??
          () {
            return Future.value();
          },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72.h,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          // mainAxisExtent: 200,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                navigateToAnotherScreenWithFadeTransition(
                    context, DetailsProductScreen(product: products[index]));
              },
              child: ProductWidget(product: products[index]));
        },
      ),
    );
  }
}
