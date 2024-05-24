part of 'get_products_expires_today_bloc.dart';

@immutable
sealed class GetProductsExpiresTodayState extends Equatable {}

final class GetProductsExpiresTodayInitial
    extends GetProductsExpiresTodayState {
  @override
  List<Object?> get props => [];
}

final class GetProductsExpiresTodayLoading
    extends GetProductsExpiresTodayState {
  @override
  List<Object?> get props => [];
}

final class GetProductsExpiresTodayLoaded extends GetProductsExpiresTodayState {
  final List<Product> products;

  GetProductsExpiresTodayLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class GetProductsExpiresTodayError extends GetProductsExpiresTodayState {
  final String message;

  GetProductsExpiresTodayError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class GetProductsExpiresTodayUnauthorized
    extends GetProductsExpiresTodayState {
  @override
  List<Object?> get props => [];
}
