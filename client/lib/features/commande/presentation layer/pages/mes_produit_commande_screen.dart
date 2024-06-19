import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/reusable_app_bar.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../bloc/get my ordered products/get_my_ordered_products_bloc.dart';
import '../widgets/mes_produit_commande_liste_view_widget.dart';

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
        appBar: ReusableAppBar(
          pageName: 'Mes produits commandés',
          leadingIcon: Icons.arrow_back,
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
                return MesProduitCommandeListViewWidget(
                  commandes: state.orderedProducts,
                );
              } else if (state is GetMyOrderedProductsError) {
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
                        text: state.message,
                        textSize: 16.sp,
                        textColor: Colors.black,
                        textFontWeight: FontWeight.w800,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
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
