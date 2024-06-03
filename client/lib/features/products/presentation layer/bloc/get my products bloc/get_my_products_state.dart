part of 'get_my_products_bloc.dart';

@immutable
sealed class GetMyProductsState extends Equatable {}

final class GetMyProductsInitial extends GetMyProductsState {
  @override
  List<Object?> get props => [];
}

final class GetMyProductsLoading extends GetMyProductsState {
  @override
  List<Object?> get props => [];
}

final class GetMyProductsLoaded extends GetMyProductsState {
  final List<Product> products;

  GetMyProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

final class GetMyProductsError extends GetMyProductsState {
  final String message;

  GetMyProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class GetMyProductsUnauthorized extends GetMyProductsState {
  @override
  List<Object?> get props => [];
}
