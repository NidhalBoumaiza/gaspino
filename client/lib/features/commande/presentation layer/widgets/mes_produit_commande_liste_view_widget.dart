import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../../../products/presentation layer/widgets/circularProgressiveIndicator.dart';
import '../../domain layer/entities/commande.dart';
import '../cubit/valide mon produit commande/valide_mon_produit_commande_cubit.dart';
import 'my_ordered_product_widget.dart';

class MesProduitCommandeListViewWidget extends StatelessWidget {
  List<Commande> commandes;

  MesProduitCommandeListViewWidget({super.key, required this.commandes});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValideMonProduitCommandeCubit,
        ValideMonProduitCommandeState>(
      listener: (context, state) {
        if (state is ValideMonProduitCommandeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReusableText(
                text: state.message,
                textSize: 14.sp,
                textColor: Colors.white,
                textFontWeight: FontWeight.w700,
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is ValideMonProduitCommandeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReusableText(
                text: 'Produit delivré avec succès',
                textSize: 14.sp,
                textColor: Colors.white,
                textFontWeight: FontWeight.w700,
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ValideMonProduitCommandeUnauthorized) {
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
          return Stack(
            children: [
              ListView.builder(
                itemCount: commandes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress:
                        commandes[index].products[0].orderedProductStatus !=
                                "delivered"
                            ? () {
                                _showBottomSheet(context, commandes[index]);
                              }
                            : null,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6.0.h),
                      child: MyOrderedProductWidget(
                        commande: commandes[index],
                      ),
                    ),
                  );
                },
              ),
              if (state is ValideMonProduitCommandeLoading)
                Center(
                  child: ReusablecircularProgressIndicator(
                    height: 20.h,
                    width: 20.w,
                    indicatorColor: primaryColor,
                  ),
                ),
            ],
          );
        }
      },
    );
  }

  void _showBottomSheet(BuildContext context, Commande commande) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.check_box, color: primaryColor),
                title: ReusableText(
                  text: 'Validé',
                  textSize: 14.sp,
                  textColor: Colors.black,
                  textFontWeight: FontWeight.w700,
                ),
                onTap: () {
                  Navigator.pop(context);

                  context
                      .read<ValideMonProduitCommandeCubit>()
                      .onUpdateProductStatusToDelivered(
                          commandeId: commande.id!,
                          productId: commande.products[0].product.id!,
                          commandes: commandes);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
