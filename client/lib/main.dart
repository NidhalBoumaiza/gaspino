import 'package:client/features/authorisation/presentation%20layer/bloc/disable_account_bloc/disable_account_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/update_user_password_bloc/update_user_password_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/pages/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'features/authorisation/presentation layer/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'features/authorisation/presentation layer/bloc/reset_password_step_one_bloc/reset_password_step_one_bloc.dart';
import 'features/authorisation/presentation layer/bloc/reset_password_step_two_bloc/reset_password_step_two_bloc.dart';
import 'features/authorisation/presentation layer/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'features/authorisation/presentation layer/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'features/authorisation/presentation layer/bloc/update_coordinate_bloc/update_coordinate_bloc.dart';
import 'features/authorisation/presentation layer/cubit/password_visibility_sign_in_cubit/password_visibility_cubit.dart';
import 'features/authorisation/presentation layer/pages/sign_in_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider(create: (create) => di.sl<PasswordVisibilityCubit>())
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (_, child) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: SignInScreen(),
              getPages: routes,
            );
          }),
    );
  }
}

final routes = [
  GetPage(name: '/signInScreen', page: () => SignInScreen()),
  GetPage(
    name: '/forgetPasswordScreen',
    page: () => ForgetPasswordScreen(),
  ),
  // GetPage(name: '/third', page: () => ThirdScreen()),
];
