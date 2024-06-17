import 'package:client/core/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../../bloc/get my products bloc/get_my_products_bloc.dart';
import '../../widgets/circularProgressiveIndicator.dart';
import '../../widgets/my products screen/my_product_list_view_widget.dart';
import '../../widgets/my products screen/shimmer_loading_my_products.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    context.read<GetMyProductsBloc>().add(GetMyProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetMyProductsBloc, GetMyProductsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetMyProductsLoading) {
            return ShimmerLoadingMyProducts();
          } else if (state is GetMyProductsLoaded) {
            return state.products.length != 0
                ? MyProductListViewWidget(
                    products: state.products,
                  )
                : Column(
                    children: [
                      SizedBox(height: 50.h),
                      SizedBox(
                        height: 350.h,
                        child: Image.asset(
                          "assets/Shops.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      ReusableText(
                        text: "Vous n'avez pas encore de produits",
                        textSize: 16.sp,
                        textFontWeight: FontWeight.w700,
                      ),
                    ],
                  );
          } else if (state is GetMyProductsError) {
            return Column(
              children: [
                SizedBox(height: 50.h),
                SizedBox(height: 350.h, child: Image.asset("assets/Shops.png")),
                ReusableText(
                  text: state.message,
                  textSize: 16.sp,
                  textFontWeight: FontWeight.w700,
                ),
              ],
            );
          } else if (state is GetMyProductsUnauthorized) {
            BlocProvider.of<SignOutBloc>(context)
                .add(SignOutMyAccountEventPressed());
            return BlocConsumer<SignOutBloc, SignOutState>(
                builder: (context, state) {
              if (state is SignOutLoading) {
                return ReusablecircularProgressIndicator(
                  height: 20.h,
                  width: 20.w,
                  indicatorColor: primaryColor,
                );
              } else {
                return const Text("errrorororororor");
              }
            }, listener: (context, state) {
              if (state is SignOutSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Votre session a expiré , veuillez vous reconnecter"),
                    backgroundColor: Colors.red,
                  ),
                );
                navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
                  context,
                  SignInScreen(),
                );
              } else if (state is SignOutError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            });
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        });
  }
}

// return BlocConsumer<GetMyProductsBloc, GetMyProductsState>(
// listener: (context, state) {},
// builder: (context, state) {
// return Container();
// });
