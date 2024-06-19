import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/utils/navigation_with_transition.dart';
import '../../../../core/widgets/reusable_app_bar.dart';
import '../../../../core/widgets/reusable_text.dart';
import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../../../products/presentation layer/widgets/circularProgressiveIndicator.dart';
import '../bloc/get my orders/get_my_orders_bloc.dart';
import '../widgets/cc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    context.read<GetMyOrdersBloc>().add(GetMyOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ReusableAppBar(
          pageName: 'Mes commandes',
          leadingIcon: Icons.arrow_back,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
          child: BlocBuilder<GetMyOrdersBloc, GetMyOrdersState>(
            builder: (context, state) {
              if (state is GetMyOrdersLoading) {
                return Center(
                  child: ReusablecircularProgressIndicator(
                      indicatorColor: primaryColor, height: 30.0, width: 30.0),
                );
              } else if (state is GetMyOrdersLoaded) {
                return cc(
                  commandes: state.commandes,
                );
              } else if (state is GetMyOrdersError) {
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
              } else if (state is GetMyOrdersUnauthenticated) {
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
