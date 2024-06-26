import 'package:client/features/authorisation/data%20layer/data%20sources/user_local_data_source.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/disable_account_bloc/disable_account_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/reset_password_step_one_bloc/reset_password_step_one_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/update_coordinate_bloc/update_coordinate_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/cubit/profile_pic_creation%20_cubit/profile_pic_creation__cubit.dart';
import 'package:client/features/commande/data%20layer/repositories/commande_repository_impl.dart';
import 'package:client/features/commande/domain%20layer/repositories/commande_repository.dart';
import 'package:client/features/commande/domain%20layer/usecases/passer_cammande_use_case.dart';
import 'package:client/features/products/data%20layer/repositories/product_repository_impl.dart';
import 'package:client/features/products/domain%20layer/repositories/product_repository.dart';
import 'package:client/features/products/presentation%20layer/bloc/get%20all%20products%20within%20distance%20bloc/get_all_products_within_distance_bloc.dart';
import 'package:client/features/products/presentation%20layer/bloc/searsh%20products%20with%20name/searsh_product_with_name_bloc.dart';
import 'package:client/features/products/presentation%20layer/cubit/confirm%20new%20password%20cubit/confirm_new_password_cubit.dart';
import 'package:client/features/products/presentation%20layer/cubit/new%20password%20cubit/new_password_cubit.dart';
import 'package:client/features/products/presentation%20layer/cubit/old%20password%20cubit/old_password_cubit.dart';
import 'package:client/features/products/presentation%20layer/cubit/product%20quantity%20cubit/product_quantity_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/authorisation/data layer/data sources/user_remote_data_source.dart';
import 'features/authorisation/data layer/repositories/user_repository_impl.dart';
import 'features/authorisation/domain layer/repositories/user_repository.dart';
import 'features/authorisation/domain layer/usecases/disable_account.dart';
import 'features/authorisation/domain layer/usecases/forget_password.dart';
import 'features/authorisation/domain layer/usecases/get_cached_user_info.dart';
import 'features/authorisation/domain layer/usecases/modify_my_information.dart';
import 'features/authorisation/domain layer/usecases/reset_password_step_one.dart';
import 'features/authorisation/domain layer/usecases/reset_password_step_two.dart';
import 'features/authorisation/domain layer/usecases/sign_in.dart';
import 'features/authorisation/domain layer/usecases/sign_out.dart';
import 'features/authorisation/domain layer/usecases/sign_up.dart';
import 'features/authorisation/domain layer/usecases/update_coordinate.dart';
import 'features/authorisation/domain layer/usecases/update_user_password.dart';
import 'features/authorisation/presentation layer/bloc/get_cached_user_info/get_cached_user_bloc.dart';
import 'features/authorisation/presentation layer/bloc/modify my information bloc/modify_my_information_bloc.dart';
import 'features/authorisation/presentation layer/bloc/reset_password_step_two_bloc/reset_password_step_two_bloc.dart';
import 'features/authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'features/authorisation/presentation layer/bloc/update_user_password_bloc/update_user_password_bloc.dart';
import 'features/authorisation/presentation layer/cubit/confirm_password_visibility_reset_password_cubit/reset_confirm_password_visibility_cubit.dart';
import 'features/authorisation/presentation layer/cubit/password_visibility_reset_password_cubit/reset_password_visibility_cubit.dart';
import 'features/authorisation/presentation layer/cubit/password_visibility_sign_in_cubit/password_visibility_cubit.dart';
import 'features/commande/data layer/data sources/commande_local_data_source.dart';
import 'features/commande/data layer/data sources/commande_remote_data_source.dart';
import 'features/commande/domain layer/usecases/cancel_one_product_from_commande.dart';
import 'features/commande/domain layer/usecases/get_my_commandes_use_case.dart';
import 'features/commande/domain layer/usecases/get_who_commande_my_product_use_case.dart';
import 'features/commande/domain layer/usecases/update_product_status_to_delivred.dart';
import 'features/commande/presentation layer/bloc/get my ordered products/get_my_ordered_products_bloc.dart';
import 'features/commande/presentation layer/bloc/get my orders/get_my_orders_bloc.dart';
import 'features/commande/presentation layer/bloc/passer commande bloc/passer_commande_bloc.dart';
import 'features/commande/presentation layer/cubit/annuler mon commande cubit/annuler_mon_commande_cubit.dart';
import 'features/commande/presentation layer/cubit/shopping card cubit/shopping_card_cubit.dart';
import 'features/commande/presentation layer/cubit/valide mon produit commande/valide_mon_produit_commande_cubit.dart';
import 'features/products/data layer/data sources/product_local_data_souce.dart';
import 'features/products/data layer/data sources/product_remote_data_source.dart';
import 'features/products/domain layer/usecases/add_product.dart';
import 'features/products/domain layer/usecases/delete_my_product.dart';
import 'features/products/domain layer/usecases/get_all_products_within_distance.dart';
import 'features/products/domain layer/usecases/get_all_products_within_distance_expires_today.dart';
import 'features/products/domain layer/usecases/get_my_products.dart';
import 'features/products/domain layer/usecases/refresh_my_products.dart';
import 'features/products/domain layer/usecases/search_product_by_name.dart';
import 'features/products/presentation layer/bloc/add produit bloc/add_produit_bloc.dart';
import 'features/products/presentation layer/bloc/get all products within distance bloc expires today/get_products_expires_today_bloc.dart';
import 'features/products/presentation layer/bloc/get my products bloc/get_my_products_bloc.dart';
import 'features/products/presentation layer/cubit/bnv cubit/bnv_cubit.dart';
import 'features/products/presentation layer/cubit/delete my product cubit/delete_my_product_cubit.dart';
import 'features/products/presentation layer/cubit/first image cubit/first_image_cubit.dart';
import 'features/products/presentation layer/cubit/slider cubit/slider_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
      () => AnnulerMonCommandeCubit(cancelOneProductFromCommande: sl()));
  sl.registerFactory(() => GetMyOrdersBloc(getMyCommandesUseCase: sl()));
  sl.registerFactory(() => PasserCommandeBloc(passerCommandeUseCase: sl()));
  sl.registerFactory(
      () => SearshProductWithNameBloc(searshProductWithNameUseCase: sl()));
  sl.registerFactory(() =>
      ValideMonProduitCommandeCubit(updateProductStatusToDelivered: sl()));
  sl.registerFactory(
      () => GetMyOrderedProductsBloc(getWhoOrderedProductsUseCase: sl()));
  sl.registerFactory(() => OldPasswordCubit());
  sl.registerFactory(() => NewPasswordCubit());
  sl.registerFactory(() => ConfirmNewPasswordCubit());
  sl.registerFactory(
      () => ModifyMyInformationBloc(modifyMyInformationUseCase: sl()));
  sl.registerFactory(() => GetCachedUserBloc(getCachedUserInfoUseCase: sl()));
  sl.registerFactory(() => DeleteMyProductCubit(deleteMyProductUseCase: sl()));
  sl.registerFactory(() => GetMyProductsBloc(
      getAllMyProductsUseCase: sl(), refreshMyProductsUseCase: sl()));
  sl.registerFactory(() => ShoppingCardCubit());
  sl.registerFactory(() => ProductQuantityCubit());
  sl.registerFactory(() => (GetProductsExpiresTodayBloc(
      getAllProductsWithinDistanceExpiresTodayUseCase: sl())));
  sl.registerFactory(() => SliderCubit());
  sl.registerFactory(() =>
      GetProductsWithinDistanceBloc(getAllProductsWithinDistanceUseCase: sl()));
  sl.registerFactory(() => FirstImageCubit());
  sl.registerFactory(() => AddProduitBloc(addProduct: sl()));
  sl.registerFactory(() => BnvCubit());
  sl.registerFactory(() => ProfilePicCreationCubit());
  sl.registerFactory(() => ResetPasswordVisibilityCubit());
  sl.registerFactory(() => ResetConfirmPasswordVisibilityCubit());
  sl.registerFactory(() => PasswordVisibilityCubit());
  sl.registerFactory(() => SignInBloc(signIn: sl()));
  sl.registerFactory(() => ForgetPasswordBloc(forgetPassword: sl()));
  sl.registerFactory(() => DisableAccountBloc(disableAccount: sl()));
  sl.registerFactory(() => SignUpBloc(signUpUseCase: sl()));
  sl.registerFactory(
      () => ResetPasswordStepOneBloc(forgetPasswordStepOneUseCase: sl()));
  sl.registerFactory(
      () => ResetPasswordStepTwoBloc(resetPasswordStepTwoUseCase: sl()));
  sl.registerFactory(() => UpdateCoordinateBloc(updateCoordinateUseCase: sl()));
  sl.registerFactory(() => SignOutBloc(signOut: sl()));
  sl.registerFactory(() => UpdateUserPasswordBloc(updatePasswordUseCase: sl()));
  // Use cases
  sl.registerLazySingleton(() => CancelOneProductFromCommande(sl()));
  sl.registerLazySingleton(() => GetMyCommandesUseCase(sl()));
  sl.registerLazySingleton(() => PasserCommandeUseCase(sl()));
  sl.registerLazySingleton(() => SearchProductByNameUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductStatusToDelivred(sl()));
  sl.registerLazySingleton(() => GetWhoCommandeMyProductUseCase(sl()));
  sl.registerLazySingleton(() => ModifyMyInformationUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMyProductUseCase(sl()));
  sl.registerLazySingleton(() => GetMyProductsUseCase(sl()));
  sl.registerLazySingleton(() => RefreshMyProductsUseCase(sl()));
  sl.registerLazySingleton(
      () => GetAllProductsWithinDistanceExpiresTodayUseCase(sl()));
  sl.registerLazySingleton(() => GetAllProductsWithinDistanceUseCase(sl()));
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => DisableAccountUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordStepOneUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordStepTwoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCoordinateUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserPasswordUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CommandeRepository>(() => CommandeRepositoryImpl(
        commandeRemoteDataSource: sl(),
        commandeLocalDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ProductRepository>(() => ProductReopositryImpl(
        productRemoteDataSource: sl(),
        productLocalDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: sl(),
        userLocalDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<CommandeRemoteDataSource>(
      () => CommandeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CommandeLocalDataSource>(
      () => CommandeLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
