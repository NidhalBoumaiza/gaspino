import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../bloc/get my ordered products/get_my_ordered_products_bloc.dart';
import '../widgets/my_ordered_product_widget.dart';

class MesProduitCommandeScreen extends StatefulWidget {
  const MesProduitCommandeScreen({super.key});

  @override
  State<MesProduitCommandeScreen> createState() =>
      _MesProduitCommandeScreenState();
}

class _MesProduitCommandeScreenState extends State<MesProduitCommandeScreen> {
  @override
  void initState() {
    context.read<GetMyOrderedProductsBloc>().add(GetMyOrderedProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: ReusableText(
            text: 'Mes produits commandés',
            textSize: 18.sp,
            textColor: Colors.white,
            textFontWeight: FontWeight.w800,
          ),
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
          child:
              BlocBuilder<GetMyOrderedProductsBloc, GetMyOrderedProductsState>(
            builder: (context, state) {
              if (state is GetMyOrderedProductsLoading) {
                return Center(
                  child: ReusablecircularProgressIndicator(
                      indicatorColor: primaryColor, height: 30.0, width: 30.0),
                );
              } else if (state is GetMyOrderedProductsLoaded) {
                return ListView.builder(
                  itemCount: state.orderedProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 6.0.h),
                      child: MyOrderedProductWidget(
                        commande: state.orderedProducts[index],
                      ),
                    );
                  },
                );
              } else if (state is GetMyOrderedProductsError) {
                return Center(
                  child: ReusableText(
                    text: state.message,
                    textSize: 16.sp,
                    textColor: Colors.black,
                    textFontWeight: FontWeight.w800,
                  ),
                );
              } else if (state is GetMyOrderedProductsNonAuthenticated) {
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
                      const SnackBar(
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
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
