import 'package:client/core/colors.dart';
import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/reusable_text.dart';
import '../../../../core/widgets/reusable_text_field_widget.dart';
import '../bloc/searsh products with name/searsh_product_with_name_bloc.dart';
import '../widgets/product home screen widgets/product_grid_view_widget.dart';

class SearshProductByNameScreen extends StatefulWidget {
  SearshProductByNameScreen({super.key});

  @override
  State<SearshProductByNameScreen> createState() =>
      _SearshProductByNameScreenState();
}

class _SearshProductByNameScreenState extends State<SearshProductByNameScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    context.read<SearshProductWithNameBloc>().add(Initialiser());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70.h,
                color: primaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<SearshProductWithNameBloc>()
                            .add(Initialiser());
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    SizedBox(
                      height: 67.h,
                      width: 290.w,
                      child: ReusableTextFieldWidget(
                        keyboardType: TextInputType.url,
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          context.read<SearshProductWithNameBloc>().add(
                              SearshProductWithName(
                                  name: searchController.text));
                        },
                        hintText: 'Recherche',
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<SearshProductWithNameBloc,
                  SearshProductWithNameState>(builder: (context, state) {
                if (state is SearshProductWithNameLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 300.h),
                      Center(
                        child: ReusablecircularProgressIndicator(
                          height: 20.h,
                          width: 20.w,
                          indicatorColor: primaryColor,
                        ),
                      ),
                    ],
                  );
                } else if (state is SearshProductWithNameLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductGridViewWidget(
                      products: state.products,
                    ),
                  );
                } else if (state is SearshProductWithNameError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 80.h),
                      SizedBox(
                        height: 300.h,
                        child: Image.asset("assets/eco.png"),
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: ReusableText(
                          text:
                              "Recherchez un produit et le sauvé de gaspillage !",
                          textSize: 16.sp,
                          textColor: Colors.black,
                          textFontWeight: FontWeight.w800,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    ));
  }
}
