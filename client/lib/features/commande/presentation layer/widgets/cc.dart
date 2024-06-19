import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../../../products/domain layer/entities/product.dart';
import '../../../products/presentation layer/widgets/circularProgressiveIndicator.dart';
import '../../domain layer/entities/commande.dart';
import '../cubit/annuler mon commande cubit/annuler_mon_commande_cubit.dart';
import 'mes_commande_widget.dart';

class cc extends StatelessWidget {
  List<Commande> commandes;

  cc({super.key, required this.commandes});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnulerMonCommandeCubit, AnnulerMonCommandeState>(
      listener: (context, state) {
        if (state is AnnulerMonCommandeError) {
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
        } else if (state is AnnulerMonCommandeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ReusableText(
                text: 'Commande annulée avec succès',
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
        if (state is AnnulerMonCommandeUnauthorized) {
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
                itemBuilder: (context, i) {
                  return Column(
                    children: commandes[i].products.map((product) {
                      return GestureDetector(
                        onLongPress: product.orderedProductStatus == 'pending'
                            ? () {
                                _showBottomSheet(
                                    context, commandes[i], product.product);
                              }
                            : null,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.0.h),
                          child: MesCommandeWidget(
                            product: product,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              if (state is AnnulerMonCommandeLoading)
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

  void _showBottomSheet(
      BuildContext context, Commande commande, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(FontAwesomeIcons.trash, color: primaryColor),
                title: ReusableText(
                  text: 'Annuler la commande',
                  textSize: 14.sp,
                  textColor: Colors.black,
                  textFontWeight: FontWeight.w700,
                ),
                onTap: () {
                  Navigator.pop(context);
                  print("product ${product.id}");
                  context
                      .read<AnnulerMonCommandeCubit>()
                      .cancelOneProductFromCommandeCubit(
                        commandeId: commande.id!,
                        productId: product.id!,
                        commandes: commandes,
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
