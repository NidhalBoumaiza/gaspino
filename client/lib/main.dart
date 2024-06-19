import 'package:client/features/authorisation/presentation%20layer/bloc/disable_account_bloc/disable_account_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/update_user_password_bloc/update_user_password_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/cubit/profile_pic_creation%20_cubit/profile_pic_creation__cubit.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/forget_password_screen.dart';
import 'package:client/features/commande/presentation%20layer/bloc/passer%20commande%20bloc/passer_commande_bloc.dart';
import 'package:client/features/products/presentation%20layer/bloc/get%20all%20products%20within%20distance%20bloc/get_all_products_within_distance_bloc.dart';
import 'package:client/features/products/presentation%20layer/bloc/searsh%20products%20with%20name/searsh_product_with_name_bloc.dart';
import 'package:client/features/products/presentation%20layer/cubit/confirm%20new%20password%20cubit/confirm_new_password_cubit.dart';
import 'package:client/features/products/presentation%20layer/cubit/new%20password%20cubit/new_password_cubit.dart';
import 'package:client/features/products/presentation%20layer/pages/home_screen_squelette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authorisation/presentation layer/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'features/authorisation/presentation layer/bloc/get_cached_user_info/get_cached_user_bloc.dart';
import 'features/authorisation/presentation layer/bloc/modify my information bloc/modify_my_information_bloc.dart';
import 'features/authorisation/presentation layer/bloc/reset_password_step_one_bloc/reset_password_step_one_bloc.dart';
import 'features/authorisation/presentation layer/bloc/reset_password_step_two_bloc/reset_password_step_two_bloc.dart';
import 'features/authorisation/presentation layer/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'features/authorisation/presentation layer/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'features/authorisation/presentation layer/bloc/update_coordinate_bloc/update_coordinate_bloc.dart';
import 'features/authorisation/presentation layer/cubit/confirm_password_visibility_reset_password_cubit/reset_confirm_password_visibility_cubit.dart';
import 'features/authorisation/presentation layer/cubit/password_visibility_reset_password_cubit/reset_password_visibility_cubit.dart';
import 'features/authorisation/presentation layer/cubit/password_visibility_sign_in_cubit/password_visibility_cubit.dart';
import 'features/authorisation/presentation layer/pages/sign_in_screen.dart';
import 'features/commande/presentation layer/bloc/get my ordered products/get_my_ordered_products_bloc.dart';
import 'features/commande/presentation layer/bloc/get my orders/get_my_orders_bloc.dart';
import 'features/commande/presentation layer/cubit/annuler mon commande cubit/annuler_mon_commande_cubit.dart';
import 'features/commande/presentation layer/cubit/shopping card cubit/shopping_card_cubit.dart';
import 'features/commande/presentation layer/cubit/valide mon produit commande/valide_mon_produit_commande_cubit.dart';
import 'features/products/presentation layer/bloc/add produit bloc/add_produit_bloc.dart';
import 'features/products/presentation layer/bloc/get all products within distance bloc expires today/get_products_expires_today_bloc.dart';
import 'features/products/presentation layer/bloc/get my products bloc/get_my_products_bloc.dart';
import 'features/products/presentation layer/cubit/bnv cubit/bnv_cubit.dart';
import 'features/products/presentation layer/cubit/delete my product cubit/delete_my_product_cubit.dart';
import 'features/products/presentation layer/cubit/first image cubit/first_image_cubit.dart';
import 'features/products/presentation layer/cubit/old password cubit/old_password_cubit.dart';
import 'features/products/presentation layer/cubit/product quantity cubit/product_quantity_cubit.dart';
import 'features/products/presentation layer/cubit/slider cubit/slider_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  await dotenv.load(fileName: ".env");
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final token = sharedPreferences.getString('token');
  Widget screen;
  if (token != null) {
    screen = const HomeScreenSquelette();
  } else {
    screen = const SignInScreen();
  }
  initializeDateFormatting('fr_FR', null)
      .then((_) => runApp(MyApp(screen: screen)));
}

class MyApp extends StatelessWidget {
  Widget screen;

  MyApp({super.key, required this.screen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (context) => di.sl<SignInBloc>(),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => di.sl<ForgetPasswordBloc>(),
        ),
        BlocProvider(create: (context) => di.sl<DisableAccountBloc>()),
        BlocProvider(create: (context) => di.sl<SignUpBloc>()),
        BlocProvider(create: (context) => di.sl<ResetPasswordStepOneBloc>()),
        BlocProvider(create: (context) => di.sl<ResetPasswordStepTwoBloc>()),
        BlocProvider(create: (context) => di.sl<UpdateCoordinateBloc>()),
        BlocProvider(create: (context) => di.sl<SignOutBloc>()),
        BlocProvider(create: (create) => di.sl<UpdateUserPasswordBloc>()),
        BlocProvider(create: (create) => di.sl<PasswordVisibilityCubit>()),
        BlocProvider(create: (create) => di.sl<ResetPasswordVisibilityCubit>()),
        BlocProvider(
            create: (create) => di.sl<ResetConfirmPasswordVisibilityCubit>()),
        BlocProvider(create: (create) => di.sl<ProfilePicCreationCubit>()),
        BlocProvider(create: (create) => di.sl<BnvCubit>()..changeIndex(0)),
        BlocProvider(create: (create) => di.sl<FirstImageCubit>()),
        BlocProvider(create: (create) => di.sl<AddProduitBloc>()),
        BlocProvider<GetProductsWithinDistanceBloc>(
            create: (context) => di.sl<GetProductsWithinDistanceBloc>()
              ..add(GetProductsWithinDistancee(distance: 10000000000000000))),
        BlocProvider(create: (create) => di.sl<SliderCubit>()),
        BlocProvider(create: (create) => di.sl<GetProductsExpiresTodayBloc>()),
        BlocProvider(create: (create) => di.sl<ProductQuantityCubit>()),
        BlocProvider(create: (create) => di.sl<ShoppingCardCubit>()),
        BlocProvider(
            create: (create) =>
                di.sl<GetMyProductsBloc>()..add(GetMyProducts())),
        BlocProvider(create: (create) => di.sl<DeleteMyProductCubit>()),
        BlocProvider(create: (create) => di.sl<GetCachedUserBloc>()),
        BlocProvider(create: (create) => di.sl<ModifyMyInformationBloc>()),
        BlocProvider(create: (create) => di.sl<OldPasswordCubit>()),
        BlocProvider(create: (create) => di.sl<ConfirmNewPasswordCubit>()),
        BlocProvider(create: (create) => di.sl<NewPasswordCubit>()),
        BlocProvider(create: (create) => di.sl<GetMyOrderedProductsBloc>()),
        BlocProvider(
            create: (create) => di.sl<ValideMonProduitCommandeCubit>()),
        BlocProvider(create: (create) => di.sl<SearshProductWithNameBloc>()),
        BlocProvider(create: (create) => di.sl<PasserCommandeBloc>()),
        BlocProvider(create: (create) => di.sl<GetMyOrdersBloc>()),
        BlocProvider(create: (create) => di.sl<AnnulerMonCommandeCubit>()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (_, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: screen,
              getPages: routes,
            );
          }),
    );
  }
}

final routes = [
  GetPage(name: '/signInScreen', page: () => const SignInScreen()),
  GetPage(
    name: '/forgetPasswordScreen',
    page: () => const ForgetPasswordScreen(),
  ),
  // GetPage(name: '/third', page: () => ThirdScreen()),
];
