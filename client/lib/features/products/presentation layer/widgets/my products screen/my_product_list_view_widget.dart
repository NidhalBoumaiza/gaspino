import 'package:client/core/colors.dart';
import 'package:client/features/products/presentation%20layer/widgets/circularProgressiveIndicator.dart';
import 'package:client/features/products/presentation%20layer/widgets/my%20products%20screen/product_widget_my_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/navigation_with_transition.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../../../domain layer/entities/product.dart';
import '../../cubit/delete my product cubit/delete_my_product_cubit.dart';

class MyProductListViewWidget extends StatelessWidget {
  final List<Product> products;

  MyProductListViewWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteMyProductCubit, DeleteMyProductState>(
      listener: (context, state) {
        if (state is DeleteMyProductSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                  'Produit supprimé avec succès',
                ),
                backgroundColor: Colors.green),
          );
        } else if (state is DeleteMyProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Erreur: ${state.message}'),
                backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is DeleteMyProductUnauthorized) {
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
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0.h, left: 8.0.w, right: 8.0.w, bottom: 20.h),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        _showBottomSheet(context, products[index]);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0.h),
                        child: ProductWidgetForMyProductsScreen(
                            product: products[index]),
                      ),
                    );
                  },
                ),
              ),
              if (state is DeleteMyProductLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                    Center(
                      child: ReusablecircularProgressIndicator(
                        indicatorColor: primaryColor,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
            ],
          );
        }
      },
    );
  }

  void _showBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Modifier'),
                onTap: () {
                  // Naviguer vers l'écran de modification
                  Navigator.pop(context);
                  // Ajoutez ici la navigation vers l'écran de modification
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.delete),
                title: ReusableText(
                  text: 'Supprimer',
                  textSize: 14.sp,
                  textColor: Colors.black,
                  textFontWeight: FontWeight.w700,
                ),
                onTap: () {
                  Navigator.pop(context);
                  context
                      .read<DeleteMyProductCubit>()
                      .deleteMyProduct(product.id, products);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
